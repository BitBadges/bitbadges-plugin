import json
from pathlib import Path
import subprocess
import shlex
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class LauncherTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.bin = Path(self.directory.name)
        self.env = {"PATH": str(self.bin), "HOME": str(self.bin)}

    def tearDown(self):
        self.directory.cleanup()

    def executable(self, name, body):
        target = self.bin / name
        target.write_text("#!/bin/sh\n" + body)
        target.chmod(0o755)

    def run_script(self, name, *args):
        return subprocess.run(["/bin/bash", str(ROOT / "scripts" / name), *args], env=self.env, capture_output=True, text=True)

    def test_doctor_preserves_cli_json_and_exit_status(self):
        payload = json.dumps({"ok": False, "data": None, "warnings": [], "error": {"code": "test_failure", "message": 'a "quoted" failure'}})
        self.executable("bitbadges-cli", "printf '%s\\n' " + shlex.quote(payload) + "\nexit 7\n")
        result = self.run_script("doctor.sh", "--json")
        self.assertEqual(result.returncode, 7)
        self.assertEqual(json.loads(result.stdout)["error"]["message"], 'a "quoted" failure')

    def test_missing_cli_returns_json_failure_without_downloading(self):
        result = self.run_script("doctor.sh", "--json")
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse(json.loads(result.stdout)["ok"])

    def test_prewarm_never_invokes_a_package_manager(self):
        self.executable("npx", 'printf called > "$HOME/download-attempt"\n')
        result = self.run_script("prewarm.sh")
        self.assertEqual(result.returncode, 0)
        self.assertFalse((self.bin / "download-attempt").exists())

    def test_mcp_uses_installed_binary_without_polluting_stdio(self):
        self.executable("bitbadges-builder", 'while IFS= read -r line; do printf "%s\\n" "$line"; done\n')
        config = json.loads((ROOT / ".mcp.json").read_text())["mcpServers"]["bitbadges-builder"]
        result = subprocess.run([config["command"], *config.get("args", [])], env=self.env, input='{"jsonrpc":"2.0"}\n', capture_output=True, text=True)
        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, '{"jsonrpc":"2.0"}\n')


if __name__ == "__main__":
    unittest.main()
