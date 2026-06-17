function switchForm(type) {
    document.querySelectorAll('.form-tab').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.form-section').forEach(s => s.classList.remove('active'));
    
    if (type === 'login') {
        document.querySelectorAll('.form-tab')[0].classList.add('active');
        document.getElementById('loginForm').classList.add('active');
    } else {
        document.querySelectorAll('.form-tab')[1].classList.add('active');
        document.getElementById('registerForm').classList.add('active');
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('loginForm');
    const registerForm = document.getElementById('registerForm');
    
    if (loginForm) {
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const u = document.getElementById('username').value;
            const p = document.getElementById('password').value;
            const err = document.getElementById('errorMsg');
            
            try {
                const res = await fetch('/api/login', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({username: u, password: p})
                });
                const data = await res.json();
                
                if(data.success) {
                    sessionStorage.setItem('role', data.role);
                    sessionStorage.setItem('username', data.officer_name);
                    
                    if(data.role === 'User') window.location.href = '/user';
                    else if(data.role === 'ResourceOfficer') window.location.href = '/officer';
                    else if(data.role === 'MonitoringAuthority') window.location.href = '/monitor';
                } else {
                    err.style.display = 'block';
                    err.textContent = data.message || 'Invalid username or password';
                }
            } catch(error) {
                err.style.display = 'block';
                err.textContent = 'Connection error';
            }
        });
    }

    if (registerForm) {
        registerForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const u = document.getElementById('reg-username').value;
            const p = document.getElementById('reg-password').value;
            const r = document.getElementById('reg-role').value;
            const err = document.getElementById('regErrorMsg');
            const success = document.getElementById('regSuccessMsg');
            
            try {
                const res = await fetch('/api/register', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({username: u, password: p, role: r})
                });
                const data = await res.json();
                
                if(data.success) {
                    err.style.display = 'none';
                    success.style.display = 'block';
                    registerForm.reset();
                    setTimeout(() => switchForm('login'), 2000);
                } else {
                    success.style.display = 'none';
                    err.style.display = 'block';
                    document.getElementById('regErrorMsg').textContent = data.message || data.error || 'Registration failed';
                    document.getElementById('regErrorMsg').style.display = 'block';
                }
            } catch (err) {
                document.getElementById('regErrorMsg').textContent = 'An error occurred during registration. Check server logs.';
            }
        });
    }
});
