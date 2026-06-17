if(sessionStorage.getItem('role') !== 'ResourceOfficer') window.location.href = '/';

document.addEventListener('DOMContentLoaded', () => {
    const msg = document.getElementById('welcomeMsg');
    const u = sessionStorage.getItem('username');
    if (msg) msg.textContent = `Welcome, ${u}`;
    
    const profName = document.getElementById('profName');
    if(profName) profName.textContent = u;
    
    init();
    
    // Bind form events
    const rainForm = document.getElementById('rainForm');
    if(rainForm) rainForm.addEventListener('submit', handleRainForm);
    
    const gwForm = document.getElementById('gwForm');
    if(gwForm) gwForm.addEventListener('submit', handleGwForm);
    
    const resForm = document.getElementById('resForm');
    if(resForm) resForm.addEventListener('submit', handleResForm);
    
    const wqForm = document.getElementById('wqForm');
    if(wqForm) wqForm.addEventListener('submit', handleWqForm);
});

function switchTab(tabId, el) {
    document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    el.classList.add('active');
    
    document.querySelectorAll('.toast').forEach(t => t.style.display = 'none');
    if(tabId === 'quality') loadReservoirs();
}

function logout() { sessionStorage.clear(); window.location.href = '/'; }

function showToast(id, msg) {
    const el = document.getElementById(id);
    if(msg) el.textContent = msg;
    el.style.display = 'block';
    setTimeout(() => el.style.display = 'none', 4000);
}

async function init() {
    loadProfile();
    try {
        const res = await fetch('/api/regions');
        const data = await res.json();
        let opts = '<option value="">Select Region...</option>';
        data.forEach(r => opts += `<option value="${r.region_id}">${r.region_name}</option>`);
        document.getElementById('rainRegion').innerHTML = opts;
        document.getElementById('gwRegion').innerHTML = opts;
        document.getElementById('resRegion').innerHTML = opts;
    } catch(e) {}
}

async function loadProfile() {
    try {
        const u = sessionStorage.getItem('username');
        const res = await fetch(`/api/profile/ResourceOfficer/${u}`);
        const data = await res.json();
        if(data.success) {
            document.getElementById('profEntries').textContent = data.count;
        }
    } catch(e) {}
}

async function loadReservoirs() {
    try {
        const res = await fetch('/api/reservoirs');
        const data = await res.json();
        let opts = '<option value="">Select Reservoir...</option>';
        data.forEach(r => opts += `<option value="${r.reservoir_id}">${r.reservoir_name}</option>`);
        document.getElementById('wqRes').innerHTML = opts;
    } catch(e) {}
}

async function handleRainForm(e) {
    e.preventDefault();
    try {
        const u = sessionStorage.getItem('username');
        const res = await fetch('/api/rainfall', {
            method: 'POST', headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ username: u, region_id: document.getElementById('rainRegion').value, record_date: document.getElementById('rainDate').value, rainfall_amount: document.getElementById('rainAmt').value })
        });
        if(res.ok) { showToast('rainSuccess'); e.target.reset(); loadProfile(); } else { const err = await res.json(); showToast('rainError', err.error); }
    } catch(err) { showToast('rainError'); }
}

async function handleGwForm(e) {
    e.preventDefault();
    try {
        const u = sessionStorage.getItem('username');
        const res = await fetch('/api/groundwater', {
            method: 'POST', headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ username: u, region_id: document.getElementById('gwRegion').value, record_date: document.getElementById('gwDate').value, depth: document.getElementById('gwDepth').value })
        });
        if(res.ok) { showToast('gwSuccess'); e.target.reset(); loadProfile(); } else { const err = await res.json(); showToast('gwError', err.error); }
    } catch(err) { showToast('gwError'); }
}

async function handleResForm(e) {
    e.preventDefault();
    try {
        const res = await fetch('/api/reservoir', {
            method: 'POST', headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ reservoir_name: document.getElementById('resName').value, region_id: document.getElementById('resRegion').value, capacity: document.getElementById('resCap').value, current_level: document.getElementById('resLvl').value })
        });
        if(res.ok) { showToast('resSuccess'); e.target.reset(); } else { const err = await res.json(); showToast('resError', err.error); }
    } catch(err) { showToast('resError'); }
}

async function handleWqForm(e) {
    e.preventDefault();
    const ph = parseFloat(document.getElementById('wqPh').value);
    if(ph < 0 || ph > 14) { document.getElementById('phErr').style.display = 'block'; return; }
    document.getElementById('phErr').style.display = 'none';
    try {
        const u = sessionStorage.getItem('username');
        const res = await fetch('/api/water-quality', {
            method: 'POST', headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ username: u, reservoir_id: document.getElementById('wqRes').value, ph_level: ph, turbidity: document.getElementById('wqTurb').value })
        });
        if(res.ok) { showToast('wqSuccess'); e.target.reset(); loadProfile(); } else { const err = await res.json(); showToast('wqError', err.error); }
    } catch(err) { showToast('wqError'); }
}
