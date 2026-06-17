if(sessionStorage.getItem('role') !== 'User') window.location.href = '/';

document.addEventListener('DOMContentLoaded', () => {
    const msg = document.getElementById('welcomeMsg');
    const u = sessionStorage.getItem('username');
    if (msg) msg.textContent = `Welcome, ${u}`;
    
    const profName = document.getElementById('profName');
    if(profName) profName.textContent = u;
    
    init();
});

function switchTab(tabId, el) {
    document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    el.classList.add('active');
    
    if(tabId === 'alerts') loadAlerts();
    if(tabId === 'regions') loadRegions();
    if(tabId === 'dashboard') loadStats();
}

function logout() {
    sessionStorage.clear();
    window.location.href = '/';
}

async function init() {
    loadStats();
    loadAlerts();
    loadRegions();
    loadProfile();
}

async function loadProfile() {
    try {
        const u = sessionStorage.getItem('username');
        const res = await fetch(`/api/profile/User/${u}`);
        const data = await res.json();
        if(data.success) {
            document.getElementById('profEntries').textContent = data.count;
        }
    } catch(e) {}
}

async function loadStats() {
    try {
        const res = await fetch('/api/dashboard/stats');
        const data = await res.json();
        document.getElementById('stat-regions').textContent = data.total_regions;
        document.getElementById('stat-reservoirs').textContent = data.total_reservoirs;
        document.getElementById('stat-alerts').textContent = data.total_active_alerts;
        document.getElementById('stat-critical').textContent = data.critical_alert_count;
    } catch(e) {}
}

async function loadAlerts() {
    try {
        const res = await fetch('/api/alerts');
        const data = await res.json();
        const tbody = document.querySelector('#alertsTable tbody');
        tbody.innerHTML = '';
        data.forEach(a => {
            const lvlCls = 'badge-' + a.alert_level.toLowerCase();
            const statusText = a.is_resolved === 'Y' ? 'Resolved' : 'Active';
            const statusCls = a.is_resolved === 'Y' ? 'status-resolved' : 'status-active';
            const actionBtn = a.is_resolved === 'N' ? `<button class="btn-resolve" onclick="resolveAlert(${a.alert_id})">Resolve</button>` : '';
            
            tbody.innerHTML += `<tr>
                <td>#${a.alert_id}</td><td>${a.region_name}</td><td>${a.alert_type}</td>
                <td><span class="badge ${lvlCls}">${a.alert_level}</span></td>
                <td>${a.alert_timestamp}</td>
                <td class="${statusCls}">${statusText}</td>
                <td>${actionBtn}</td>
            </tr>`;
        });
    } catch(e) {}
}

async function loadRegions() {
    try {
        const res = await fetch('/api/regions');
        const data = await res.json();
        const tbody = document.querySelector('#regionsTable tbody');
        tbody.innerHTML = '';
        data.forEach(r => {
            tbody.innerHTML += `<tr><td>${r.region_name}</td><td>${r.state}</td><td>${r.population || '-'}</td><td>${r.climate_type || '-'}</td></tr>`;
        });
    } catch(e) {}
}

async function resolveAlert(id) {
    if(!confirm('Mark alert as resolved?')) return;
    try {
        const u = sessionStorage.getItem('username');
        const res = await fetch(`/api/alerts/resolve/${id}`, {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({username: u})
        });
        const data = await res.json();
        if(data.success) {
            loadAlerts();
            loadStats();
            loadProfile();
        }
    } catch(e) {}
}
