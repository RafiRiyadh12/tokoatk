<%-- 
    Document   : formsalestambah
    Created on : Jun 17, 2025, 11:06:52 AM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="java.util.*, tokoatk2.Barang" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    ArrayList<Barang> daftarBarang = Barang.getList();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Tambah Transaksi</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f5f1e9;
            font-family: 'Inter', sans-serif;
            color: #333;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            overflow-y: auto;
            scroll-behavior: smooth;
        }

        .form-container {
            width: 90%;
            max-width: 1100px;
            padding: 30px 40px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            border-left: 4px solid #4a4e69;
            margin-top: 40px;
            text-align: center;
            max-height: 90vh;
            overflow-y: auto;
            will-change: transform;
        }

        h2 {
            font-family: 'Roboto', sans-serif;
            font-size: 24px;
            font-weight: 500;
            color: #4a4e69;
            margin-bottom: 25px;
        }

        .header-controls {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }

        .control-left, .control-right {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 10px;
        }

        select, input[type="number"], input[type="text"] {
            padding: 8px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background: #f9f9f9;
            color: #333;
            font-size: 14px;
            text-align: left;
            outline: none;
            transition: border-color 0.3s ease;
        }

        select {
            appearance: none;
            background-color: #ffffff;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 10 10'%3E%3Cpath fill='%234a4e69' d='M0 3l5 5 5-5z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 12px;
            padding-right: 24px;
            min-width: 200px;
        }

        select:focus, input[type="number"]:focus, input[type="text"]:focus {
            border-color: #4a4e69;
            background: #fff;
        }

        button {
            padding: 8px 14px;
            background: #4a4e69;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #3a3d52;
        }

        .back-link {
            padding: 8px 12px;
            border: 1px solid #4a4e69;
            border-radius: 4px;
            color: #4a4e69;
            background: transparent;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s ease, color 0.3s ease;
        }

        .back-link:hover {
            background: #4a4e69;
            color: #ffffff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            color: #34495e;
            font-size: 14px;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        #tabelRingkasan {
            display: none;
        }

        button[type="submit"] {
            width: auto;
            padding: 8px 24px;
            margin-bottom: 20px;
        }

        #totalKeseluruhan {
            text-align: left;
            margin-bottom: 15px;
            padding: 10px;
            background: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            color: #4a4e69;
            font-weight: 600;
            display: none;
        }

        #totalPopup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 300px;
            padding: 20px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #4a4e69;
            text-align: center;
            z-index: 1000;
        }

        #popupContent {
            margin-bottom: 20px;
            font-size: 16px;
            color: #2c3e50;
            font-weight: 600;
        }

        #closePopupBtn {
            padding: 8px 20px;
            background: #4a4e69;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s ease;
        }

        #closePopupBtn:hover {
            background: #3a3d52;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
            }
            .header-controls {
                flex-direction: column;
                align-items: stretch;
            }
            .control-left, .control-right {
                width: 100%;
                justify-content: space-between;
            }
            select {
                min-width: 150px;
            }
            #totalKeseluruhan {
                font-size: 14px;
                padding: 8px;
            }
            #totalPopup {
                width: 250px;
                padding: 15px;
            }
            #popupContent {
                font-size: 14px;
            }
            #closePopupBtn {
                padding: 6px 15px;
                font-size: 13px;
            }
        }

        @media (max-width: 480px) {
            .form-container {
                margin-top: 20px;
                padding: 15px;
            }
            h2 {
                font-size: 20px;
            }
            select, input[type="number"], input[type="text"] {
                font-size: 13px;
                padding: 6px 8px;
            }
            button, .back-link {
                font-size: 13px;
                padding: 6px 10px;
            }
            button[type="submit"] {
                padding: 6px 18px;
            }
            #totalKeseluruhan {
                font-size: 12px;
                padding: 6px;
            }
            #totalPopup {
                width: 200px;
                padding: 10px;
            }
            #popupContent {
                font-size: 12px;
            }
            #closePopupBtn {
                padding: 5px 12px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Tambah Transaksi</h2>

        <form action="salestambah.jsp" method="post" id="formTransaksi">
            <div class="header-controls">
                <div class="control-left">
                    <select id="barangSelect">
                        <option value="" disabled selected hidden>Pilih Barang</option>
                        <% for (Barang b : daftarBarang) { %>
                            <option value="<%= b.id %>" data-nama="<%= b.nama %>" data-harga="<%= b.harga %>"><%= b.nama %> (Stok: <%= b.stok %>)</option>
                        <% } %>
                    </select>
                    <input type="number" id="jumlahInput" min="1" placeholder="Jumlah">
                    <button type="button" onclick="tambahBarang()">+ Tambah</button>
                </div>

                <div class="control-right">
                    <label for="id_transaksi">ID Transaksi:</label>
                    <input type="text" id="id_transaksi" placeholder="ID Transaksi">
                    <button type="button" id="getTotalBtn" onclick="hitungTotal()">Get Total</button>
                    <a href="home.jsp" class="back-link">Home</a>
                    <a href="saleslist.jsp" class="back-link">Daftar Transaksi</a>
                </div>
            </div>

            <div id="totalKeseluruhan">
                Total Keseluruhan: Rp<span id="totalAmount">0</span>
            </div>

            <button type="submit">Simpan Transaksi</button>

            <table id="tabelRingkasan">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>ID Barang</th>
                        <th>Nama Barang</th>
                        <th>Harga</th>
                        <th>Jumlah</th>
                        <th>Total Harga</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody id="ringkasanBody"></tbody>
            </table>

            <div id="hiddenInputs"></div>
        </form>

        <div id="totalPopup">
            <div id="popupContent">Total Berdasarkan ID: Rp<span id="totalResult">0</span></div>
            <button id="closePopupBtn" onclick="document.getElementById('totalPopup').style.display='none'">Oke</button>
        </div>
    </div>

    <script>
        let dataBarang = [];

        function tambahBarang() {
            const barangSelect = document.getElementById("barangSelect");
            const jumlahInput = document.getElementById("jumlahInput");
            const idBarang = barangSelect.value;
            const jumlah = jumlahInput.value;

            if (!idBarang || !jumlah || parseInt(jumlah) <= 0) {
                alert("Pilih barang dan masukkan jumlah lebih dari 0!");
                return;
            }

            const namaBarang = barangSelect.options[barangSelect.selectedIndex].text.split(" (")[0];
            const hargaBarang = parseFloat(barangSelect.options[barangSelect.selectedIndex].getAttribute("data-harga"));
            console.log("ID:", idBarang, "Nama:", namaBarang, "Harga:", hargaBarang, "Jumlah:", jumlah);

            dataBarang.push({ id: idBarang, nama: namaBarang, harga: hargaBarang, qty: jumlah });
            renderTabel();
            resetFormInput();
        }

        function renderTabel() {
            const ringkasan = document.getElementById("ringkasanBody");
            const table = document.getElementById("tabelRingkasan");
            const hiddenInputs = document.getElementById("hiddenInputs");
            const totalKeseluruhan = document.getElementById("totalKeseluruhan");
            const totalAmount = document.getElementById("totalAmount");

            // Batch update DOM
            const fragment = document.createDocumentFragment();
            hiddenInputs.innerHTML = ""; // Clear hidden inputs sebelum append

            dataBarang.forEach((item, index) => {
                const row = document.createElement("tr");

                const noCell = document.createElement("td");
                noCell.textContent = index + 1;

                const idCell = document.createElement("td");
                idCell.textContent = item.id;

                const namaCell = document.createElement("td");
                namaCell.textContent = item.nama;

                const hargaCell = document.createElement("td");
                hargaCell.textContent = "Rp" + item.harga.toLocaleString("id-ID");

                const jumlahCell = document.createElement("td");
                jumlahCell.textContent = item.qty;

                const totalHargaCell = document.createElement("td");
                totalHargaCell.textContent = "Rp" + (item.harga * item.qty).toLocaleString("id-ID");

                const aksiCell = document.createElement("td");
                const btn = document.createElement("button");
                btn.type = "button";
                btn.textContent = "Hapus";
                btn.onclick = () => hapusBarang(index);
                aksiCell.appendChild(btn);

                row.appendChild(noCell);
                row.appendChild(idCell);
                row.appendChild(namaCell);
                row.appendChild(hargaCell);
                row.appendChild(jumlahCell);
                row.appendChild(totalHargaCell);
                row.appendChild(aksiCell);

                fragment.appendChild(row);

                const inputId = document.createElement("input");
                inputId.type = "hidden";
                inputId.name = "id_barang[]";
                inputId.value = item.id;

                const inputQty = document.createElement("input");
                inputQty.type = "hidden";
                inputQty.name = "jumlah[]";
                inputQty.value = item.qty;

                hiddenInputs.appendChild(inputId);
                hiddenInputs.appendChild(inputQty);
            });

            ringkasan.innerHTML = ""; // Clear sebelum append
            ringkasan.appendChild(fragment); // Append sekali saja

            // Hitung Total Keseluruhan
            const total = dataBarang.reduce((sum, item) => sum + (item.harga * item.qty), 0);
            totalAmount.textContent = total.toLocaleString("id-ID");
            totalKeseluruhan.style.display = dataBarang.length > 0 ? "block" : "none";

            table.style.display = dataBarang.length > 0 ? "table" : "none";
            console.log("Hidden Inputs:", hiddenInputs.innerHTML);
        }

        function hapusBarang(index) {
            dataBarang.splice(index, 1);
            renderTabel();
        }

        function resetFormInput() {
            document.getElementById("barangSelect").selectedIndex = 0;
            document.getElementById("jumlahInput").value = "";
        }

        function hitungTotal() {
            const id = document.getElementById("id_transaksi").value;
            const totalResult = document.getElementById("totalResult");
            const totalPopup = document.getElementById("totalPopup");

            if (!id.trim()) {
                alert("Masukkan ID Transaksi terlebih dahulu!");
                return;
            }

            fetch("api.salestotal.jsp", {
                method: "POST",
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: "id=" + encodeURIComponent(id)
            })
            .then(response => response.text())
            .then(data => {
                totalResult.textContent = data.toLocaleString("id-ID");
                totalPopup.style.display = "block";
            })
            .catch(error => {
                console.error("Error fetching total:", error);
                totalResult.textContent = "0";
                totalPopup.style.display = "block";
            });
        }
    </script>
</body>
</html>