<%-- 
    Document   : baranglist.view
    Created on : Jun 16, 2025, 8:17:07 PM
    Author     : M Rafi RiyadhI
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="tokoatk2.Barang, java.util.ArrayList" %>
<%
    ArrayList<Barang> allBarangList = Barang.getList();
    ArrayList<Barang> barangList = new ArrayList<>();
    for (Barang b : allBarangList) {
        if (b.isActive()) { // Cuma tampilkan yang aktif
            barangList.add(b);
        }
    }
    pageContext.setAttribute("barangList", barangList);
    // Tambah list barang non-aktif buat opsi aktifkan
    ArrayList<Barang> inactiveBarangList = new ArrayList<>();
    for (Barang b : allBarangList) {
        if (!b.isActive()) { // Ambil yang non-aktif
            inactiveBarangList.add(b);
        }
    }
    pageContext.setAttribute("inactiveBarangList", inactiveBarangList);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Daftar Barang</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background: #f5f1e9; font-family: 'Inter', sans-serif; color: #333; height: 100vh; overflow: hidden; }
        .container { max-width: 900px; width: 100%; margin: 40px auto; padding: 30px; background: #ffffff; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); border-left: 4px solid #4a4e69; max-height: 85vh; overflow-y: auto; }
        h1 { font-family: 'Roboto', sans-serif; font-size: 24px; font-weight: 500; color: #4a4e69; text-align: center; margin-bottom: 20px; }
        .button-group { text-align: center; margin-bottom: 20px; }
        .button-group a { display: inline-block; background: #4a4e69; color: #ffffff; text-decoration: none; padding: 12px 20px; border-radius: 4px; font-weight: 600; margin: 0 10px; transition: background 0.3s ease; }
        .button-group a:hover { background: #3a3d52; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: center; border-bottom: 1px solid #ddd; }
        th { background: #ecf0f1; color: #4a4e69; font-weight: 600; }
        td { color: #34495e; }
        tr:hover { background: #f9f9f9; }
        a.aksi-link { color: #4a4e69; font-weight: 600; text-decoration: none; margin: 0 5px; transition: color 0.3s ease; }
        a.aksi-link:hover { color: #3a3d52; }
        .inactive-section { margin-top: 20px; }
        .inactive-section h2 { font-size: 20px; color: #4a4e69; margin-bottom: 10px; }
        @media (max-width: 768px) { .container { margin: 20px; padding: 20px; } table { font-size: 14px; } .button-group a { padding: 10px 15px; margin: 0 5px; } }
        @media (max-width: 480px) { .container { width: 90%; margin: 10px; padding: 15px; } h1 { font-size: 20px; } table th, table td { padding: 8px; } .button-group a { display: block; margin: 5px 0; } }
        .confirm-popup { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); text-align: center; z-index: 1001; width: 300px; }
        .confirm-popup.show { display: block; animation: fadeIn 0.3s ease-in; }
        .confirm-text { font-size: 18px; color: #e74c3c; margin-bottom: 20px; }
        .confirm-buttons { display: flex; justify-content: space-around; }
        .confirm-btn { padding: 10px 20px; border: none; border-radius: 4px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background 0.3s ease; }
        .confirm-btn.yes { background: #e74c3c; color: #ffffff; }
        .confirm-btn.yes:hover { background: #c0392b; }
        .confirm-btn.no { background: #bdc3c7; color: #ffffff; }
        .confirm-btn.no:hover { background: #95a5a6; }
        .stat-popup { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); text-align: center; z-index: 1000; width: 300px; }
        .stat-popup.show { display: block; }
        .stat-text { font-size: 18px; color: #4a4e69; margin: 10px 0; }
        .stat-btn { padding: 10px 20px; border: none; border-radius: 4px; font-size: 14px; font-weight: 600; cursor: pointer; background: #4a4e69; color: #ffffff; transition: background 0.3s ease; }
        .stat-btn:hover { background: #3a3d52; }
        .edit-nama-popup { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); text-align: center; z-index: 1000; width: 300px; }
        .edit-nama-popup.show { display: block; }
        .edit-nama-text { font-size: 18px; color: #4a4e69; margin-bottom: 10px; }
        .edit-nama-input { width: 80%; padding: 8px; margin: 10px 0; border: 1px solid #ddd; border-radius: 4px; }
        .edit-nama-buttons { margin-top: 15px; }
        .edit-nama-btn { padding: 10px 20px; border: none; border-radius: 4px; font-size: 14px; font-weight: 600; cursor: pointer; margin: 0 5px; transition: background 0.3s ease; }
        .edit-nama-btn.ok { background: #4a4e69; color: #ffffff; }
        .edit-nama-btn.ok:hover { background: #3a3d52; }
        .edit-nama-btn.cancel { background: #bdc3c7; color: #ffffff; }
        .edit-nama-btn.cancel:hover { background: #95a5a6; }
        .success-popup { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); text-align: center; z-index: 1000; width: 300px; }
        .success-popup.show { display: block; animation: fadeIn 0.3s ease-in; }
        .checkmark { width: 50px; height: 50px; display: block; margin: 0 auto 10px; }
        .checkmark-circle { stroke: #2ecc71; fill: #2ecc71; stroke-width: 2; stroke-miterlimit: 10; }
        .checkmark-check { stroke: #ffffff; fill: none; stroke-width: 5; stroke-linecap: round; stroke-miterlimit: 10; animation: draw-check 0.5s ease-in-out forwards; }
        .fail-popup { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); text-align: center; z-index: 1000; width: 300px; }
        .fail-popup.show { display: block; animation: fadeIn 0.3s ease-in; }
        .fail-icon { width: 50px; height: 50px; display: block; margin: 0 auto 10px; }
        .fail-circle { stroke: #e74c3c; fill: #e74c3c; stroke-width: 2; stroke-miterlimit: 10; }
        .fail-cross { stroke: #ffffff; fill: none; stroke-width: 5; stroke-linecap: round; stroke-miterlimit: 10; animation: draw-cross 0.5s ease-in-out forwards; }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes draw-check { 0% { stroke-dasharray: 50; stroke-dashoffset: 50; } 100% { stroke-dasharray: 50; stroke-dashoffset: 0; } }
        @keyframes draw-cross { 0% { stroke-dasharray: 50; stroke-dashoffset: 50; } 100% { stroke-dasharray: 50; stroke-dashoffset: 0; } }
    </style>
</head>
<body>
    <div class="container">
        <h1>Daftar Barang</h1>
        <div class="button-group">
            <a href="formtambahbarang.jsp">Tambah Barang</a>
            <a href="home.jsp">Kembali ke Home</a>
            <a href="#" onclick="showStat()">Lihat Statistik</a>
        </div>
        <table>
            <tr>
                <th>NO</th>
                <th>ID BARANG</th>
                <th>NAMA BARANG</th>
                <th>HARGA</th>
                <th>STOK</th>
                <th>AKSI</th>
            </tr>
            <c:set var="no" value="1" />
            <c:forEach var="barang" items="${barangList}">
                <tr>
                    <td>${no}</td>
                    <td>${barang.id}</td>
                    <td><span id="nama${barang.id}">${barang.nama}</span></td>
                    <td>Rp<fmt:formatNumber value="${barang.harga}" type="number" groupingUsed="true"/></td>
                    <td>${barang.stok}</td>
                    <td>
                        <a href="#" class="aksi-link" onclick="gantiNama('${barang.id}')">Edit Nama</a> |
                        <a class="aksi-link" href="barangedit.jsp?id=${barang.id}">Edit</a> |
                        <a class="aksi-link" href="#" class="delete-btn" data-id="${barang.id}" onclick="showConfirmPopup('${barang.id}'); return false;">Hapus</a>
                    </td>
                </tr>
                <c:set var="no" value="${no + 1}" />
            </c:forEach>
        </table>

        <!-- Section untuk barang non-aktif -->
        <c:if test="${not empty inactiveBarangList}">
            <div class="inactive-section">
                <h2>Barang Non-Aktif</h2>
                <table>
                    <tr>
                        <th>ID BARANG</th>
                        <th>NAMA BARANG</th>
                        <th>AKSI</th>
                    </tr>
                    <c:forEach var="inactiveBarang" items="${inactiveBarangList}">
                        <tr>
                            <td>${inactiveBarang.id}</td>
                            <td>${inactiveBarang.nama}</td>
                            <td>
                                <a class="aksi-link" href="#" onclick="activateBarang('${inactiveBarang.id}'); return false;">Aktifkan</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </c:if>
    </div>

    <!-- Popup Konfirmasi Hapus -->
    <div id="confirmPopup" class="confirm-popup">
        <div class="confirm-text">Yakin ingin menghapus barang ini?</div>
        <div class="confirm-buttons">
            <button class="confirm-btn yes" onclick="confirmDelete()">Ya</button>
            <button class="confirm-btn no" onclick="hideConfirmPopup()">Tidak</button>
        </div>
    </div>

    <!-- Popup Statistik -->
    <div id="statPopup" class="stat-popup">
        <div class="stat-text" id="statMessage"></div>
        <button class="stat-btn" onclick="hideStatPopup()">Oke</button>
    </div>

    <!-- Popup Edit Nama -->
    <div id="editNamaPopup" class="edit-nama-popup">
        <div class="edit-nama-text">Edit Nama Barang</div>
        <input type="text" id="editNamaInput" class="edit-nama-input" placeholder="Masukkan nama baru">
        <div class="edit-nama-buttons">
            <button class="edit-nama-btn ok" onclick="saveNama()">Oke</button>
            <button class="edit-nama-btn cancel" onclick="hideEditNamaPopup()">Batal</button>
        </div>
    </div>

    <!-- Popup Sukses -->
    <div id="successPopup" class="success-popup">
        <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="checkmark-circle" cx="26" cy="26" r="25" />
            <path class="checkmark-check" d="M14 22 L22 30 L36 16" />
        </svg>
        <div class="success-text">Sukses!</div>
        <div class="success-message" id="successMessage"></div>
    </div>

    <script>
        let deleteId = null;
        let editId = null;

        function gantiNama(id) {
            editId = id;
            const currentName = $('#nama' + id).text();
            const input = document.getElementById('editNamaInput');
            input.value = currentName; // Isi input dengan nama saat ini
            const popup = document.getElementById('editNamaPopup');
            popup.classList.add('show');
            console.log("Ganti Nama: ID = " + id + ", Current Name = " + currentName);
        }

        function saveNama() {
            const newName = document.getElementById('editNamaInput').value.trim();
            if (newName && editId) {
                console.log("Save Nama: ID = " + editId + ", New Name = " + newName);
                $.ajax({
                    url: "api.baranggantinama.jsp",
                    method: "POST",
                    data: { id: editId, namabaru: newName },
                    async: true,
                    success: function(result) {
                        console.log("Response from server: " + result);
                        result = result.trim();
                        if (result.toLowerCase().includes("ok")) { // Cek apakah ada "ok" di response
                            window.location.href = "baranglist.jsp";
                            window.location.reload(); // Force reload setelah redirect
                        } else {
                            hideEditNamaPopup();
                            console.log("Gagal: Response = " + result);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.log("AJAX Error: " + status + " - " + error);
                        hideEditNamaPopup();
                    }
                });
            } else {
                console.log("Save Nama: Input kosong atau ID tidak valid");
                hideEditNamaPopup();
            }
        }

        function hideEditNamaPopup() {
            const popup = document.getElementById('editNamaPopup');
            popup.classList.remove('show');
        }

        function showStat() {
            $.post("api.barangstat.jsp", function(result) {
                let obj = JSON.parse(result);
                let message = "Banyak data: " + obj.banyak + "<br>Rata-rata: Rp" + Math.round(obj.rata2).toLocaleString();
                const statMessage = document.getElementById('statMessage');
                statMessage.innerHTML = message;
                const popup = document.getElementById('statPopup');
                popup.classList.add('show');
            });
        }

        function hideStatPopup() {
            const popup = document.getElementById('statPopup');
            popup.classList.remove('show');
        }

        function showConfirmPopup(id) {
            deleteId = id;
            const popup = document.getElementById('confirmPopup');
            popup.classList.add('show');
        }

        function hideConfirmPopup() {
            const popup = document.getElementById('confirmPopup');
            popup.classList.remove('show');
        }

        function confirmDelete() {
            if (deleteId) {
                window.location.href = "baranghapus.jsp?id=" + encodeURIComponent(deleteId);
            }
            hideConfirmPopup();
        }

        function activateBarang(id) {
            window.location.href = "barangaktif.jsp?id=" + encodeURIComponent(id);
        }

        function showSuccessPopup(message) {
            const popup = document.getElementById('successPopup');
            const successMessage = document.getElementById('successMessage');
            successMessage.textContent = message;
            popup.classList.add('show');
            setTimeout(() => {
                popup.classList.remove('show');
            }, 2000); // Hide after 2 seconds
        }

        // Handle success/error from URL params
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const success = urlParams.get('success');
            const error = urlParams.get('error');
            if (success) {
                showSuccessPopup(success);
            } else if (error) {
                showSuccessPopup(error); // Reuse success popup for error (can customize later)
            }
        };
    </script>
</body>
</html>