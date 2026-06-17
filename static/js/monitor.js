if(sessionStorage.getItem('role') !== 'MonitoringAuthority') window.location.href = '/';

Chart.defaults.color = '#7A7A7A';
Chart.defaults.borderColor = 'rgba(10,10,10,0.1)';
let overviewChart = null;
let trendChart = null;

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
    
    if(tabId === 'overview') { loadStats(); loadOverviewChart(); }
    if(tabId === 'alerts') loadAlerts();
    if(tabId === 'reservoirs') loadReservoirsTable();
    if(tabId === 'quality') loadQuality();
}

function logout() { sessionStorage.clear(); window.location.href = '/'; }

async function init() {
    try {
        const res = await fetch('/api/regions');
        const data = await res.json();
        let opts = '';
        data.forEach(r => opts += `<option value="${r.region_id}">${r.region_name}</option>`);
        document.getElementById('alertFilter').innerHTML += opts;
        document.getElementById('trendFilter').innerHTML += opts;
        loadStats(); loadOverviewChart();
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

async function loadOverviewChart() {
    try {
        const res = await fetch('/api/reservoirs');
        const data = await res.json();
        const labels = data.map(d => d.reservoir_name);
        const fills = data.map(d => d.fill_percentage);
        const colors = fills.map(f => f < 20 ? '#FF6B35' : (f < 50 ? '#0A0A0A' : '#7A7A7A'));
        
        if(overviewChart) overviewChart.destroy();
        overviewChart = new Chart(document.getElementById('overviewChart'), {
            type: 'bar',
            data: { labels, datasets: [{ label: 'Fill Percentage (%)', data: fills, backgroundColor: colors, borderRadius: 4 }] },
            options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false, scales: { x: { max: 100 } } }
        });
    } catch(e) {}
}

async function loadAlerts() {
    const regId = document.getElementById('alertFilter').value;
    const url = regId ? `/api/alerts/${regId}` : '/api/alerts';
    try {
        const res = await fetch(url);
        const data = await res.json();
        const tbody = document.querySelector('#alertsTable tbody');
        tbody.innerHTML = '';
        data.forEach(a => {
            const lvlCls = 'badge-' + a.alert_level.toLowerCase();
            const statusText = a.is_resolved === 'Y' ? 'Resolved' : 'Active';
            tbody.innerHTML += `<tr>
                <td>#${a.alert_id}</td><td>${a.region_name}</td><td>${a.alert_type}</td>
                <td><span class="badge ${lvlCls}">${a.alert_level}</span></td>
                <td>${a.alert_timestamp}</td><td>${statusText}</td>
            </tr>`;
        });
    } catch(e) {}
}

async function loadReservoirsTable() {
    try {
        const res = await fetch('/api/reservoirs');
        const data = await res.json();
        const tbody = document.querySelector('#resTable tbody');
        tbody.innerHTML = '';
        data.forEach(r => {
            const pct = r.fill_percentage;
            const color = pct < 20 ? '#FF6B35' : (pct < 50 ? '#0A0A0A' : '#7A7A7A');
            tbody.innerHTML += `<tr>
                <td>${r.reservoir_name}</td><td>${r.region_name}</td>
                <td>${r.capacity}</td><td>${r.current_level}</td>
                <td>
                    <div class="progress-bg"><div class="progress-fill" style="width:${pct}%; background-color:${color}"></div></div>
                    <span style="font-size:12px">${pct}%</span>
                </td>
            </tr>`;
        });
    } catch(e) {}
}

async function loadQuality() {
    try {
        const res = await fetch('/api/water-quality');
        const data = await res.json();
        const tbody = document.querySelector('#wqTable tbody');
        tbody.innerHTML = '';
        data.forEach(q => {
            const phBad = q.ph_level < 6.5 || q.ph_level > 8.5;
            const turbBad = q.turbidity > 5;
            tbody.innerHTML += `<tr>
                <td>${q.reservoir_name}</td><td>${q.region_name}</td>
                <td class="${phBad ? 'bg-critical' : 'bg-safe'}">${q.ph_level}</td>
                <td class="${turbBad ? 'bg-critical' : 'bg-safe'}">${q.turbidity}</td>
            </tr>`;
        });
    } catch(e) {}
}

async function loadTrends() {
    const regId = document.getElementById('trendFilter').value;
    if(!regId) {
        if(trendChart) { trendChart.destroy(); trendChart = null; }
        return;
    }
    const textName = document.getElementById('trendFilter').options[document.getElementById('trendFilter').selectedIndex].text;
    try {
        const res = await fetch(`/api/rainfall/${regId}`);
        const data = await res.json();
        data.reverse();
        const labels = data.map(d => d.record_date);
        const amts = data.map(d => d.rainfall_amount);
        
        if(trendChart) trendChart.destroy();
        trendChart = new Chart(document.getElementById('trendChart'), {
            type: 'line',
            data: { labels, datasets: [{ label: `Rainfall (mm)`, data: amts, borderColor: '#FF6B35', backgroundColor: 'rgba(255, 107, 53, 0.1)', fill: true, tension: 0 }] },
            options: { responsive: true, maintainAspectRatio: false, plugins: { title: { display: true, text: `Rainfall Trend — ${textName}` } } }
        });
    } catch(e) {}
}
