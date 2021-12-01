const { spawn } = require('child_process');
const { resolve } = require('path');
const pwsh = spawn('pwsh', ['-f', resolve(__dirname, 'login.ps1')]);

pwsh.stdout.on('data', data => {
    console.log(`${data}`);
});

pwsh.stderr.on('data', data => {
    console.error(`${data}`);
});

pwsh.on('close', code => {
    process.exit(code);
});
