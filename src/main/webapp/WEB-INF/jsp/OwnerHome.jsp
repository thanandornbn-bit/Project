<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ page session="true" %>
                <%@ page import="com.springmvc.model.Manager" %>
                    <%@ page import="java.util.*" %>

                        <% Manager loginManager=(Manager) session.getAttribute("loginManager"); if (loginManager==null)
                            { response.sendRedirect("Login"); return; } %>

                            <!DOCTYPE html>
                            <html lang="th">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Manager Dashboard - ThanaChok Place</title>
                                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                                    rel="stylesheet">
                                <link
                                    href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
                                    rel="stylesheet">
                                <style>
                                    :root {
                                        --bg: #FFFFFF;
                                        --muted-bg: #F0F7FF;
                                        --primary: #5CA9E9;
                                        --primary-dark: #4A90E2;
                                        --primary-light: #7BC4FF;
                                        --accent: #E3F2FD;
                                        --text: #1E3A5F;
                                        --text-light: #FFFFFF;
                                        --muted-text: #5B7A9D;
                                        --bg-secondary: #F8FCFF;
                                        --border: #D1E8FF;
                                        --card-border: #D1E8FF;
                                        --hover-bg: #E8F4FF;
                                        --shadow: rgba(92, 169, 233, 0.15);
                                        --success: #4CAF50;
                                        --warning: #FF9800;
                                        --danger: #F44336;
                                    }

                                    * {
                                        margin: 0;
                                        padding: 0;
                                        box-sizing: border-box;
                                    }

                                    body {
                                        font-family: 'Sarabun', system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
                                        background: var(--bg);
                                        color: var(--text);
                                        min-height: 100vh;
                                    }

                                    .page-container {
                                        width: 100%;
                                        min-height: 100vh;
                                        display: flex;
                                        flex-direction: column;
                                    }

                                    .header {
                                        background: var(--bg);
                                        padding: 18px 48px;
                                        display: flex;
                                        align-items: center;
                                        justify-content: space-between;
                                        border-bottom: 2px solid var(--accent);
                                        position: sticky;
                                        top: 0;
                                        z-index: 50;
                                        box-shadow: 0 2px 8px rgba(74, 144, 226, 0.08);
                                    }

                                    .header h1 {
                                        font-size: 2.5rem;
                                        color: var(--primary);
                                        font-weight: 700;
                                        display: flex;
                                        align-items: center;
                                        gap: 12px;
                                    }

                                    .nav-menu {
                                        display: flex;
                                        gap: 28px;
                                        align-items: center;
                                    }

                                    .nav-link {
                                        color: var(--muted-text);
                                        text-decoration: none;
                                        font-weight: 600;
                                        padding: 8px 12px;
                                        border-radius: 8px;
                                        transition: all 0.3s ease;
                                    }

                                    .nav-link.active {
                                        color: var(--primary);
                                        background: var(--accent);
                                    }

                                    .nav-link:hover {
                                        color: var(--primary);
                                        background: var(--hover-bg);
                                    }

                                    .user-section {
                                        display: flex;
                                        gap: 16px;
                                        align-items: center;
                                    }

                                    .user-info {
                                        display: flex;
                                        align-items: center;
                                        gap: 10px;
                                        color: var(--muted-text);
                                        font-weight: 600;
                                        padding: 10px 16px;
                                        background: var(--accent);
                                        border-radius: 10px;
                                    }

                                    .user-info i {
                                        color: var(--primary);
                                        font-size: 1.2rem;
                                    }

                                    .logout-btn {
                                        background: linear-gradient(135deg, #EF4444 0%, #DC2626 100%);
                                        color: white;
                                        border: none;
                                        padding: 10px 20px;
                                        border-radius: 10px;
                                        font-weight: 700;
                                        font-family: 'Sarabun', sans-serif;
                                        cursor: pointer;
                                        transition: all 0.3s ease;
                                        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
                                    }

                                    .logout-btn:hover {
                                        box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
                                        transform: translateY(-2px);
                                    }


                                    .search-section {
                                        background: linear-gradient(135deg, var(--muted-bg) 0%, #E8F4FF 100%);
                                        padding: 32px 48px;
                                        border-bottom: 1px solid var(--card-border);
                                    }

                                    .stats-container {
                                        display: grid;
                                        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                                        gap: 20px;
                                        margin-bottom: 30px;
                                    }

                                    .stat-card {
                                        background: var(--bg);
                                        padding: 28px;
                                        border-radius: 16px;
                                        text-align: center;
                                        border: 2px solid var(--border);
                                        transition: all 0.3s ease;
                                        position: relative;
                                        overflow: hidden;
                                        box-shadow: 0 4px 16px var(--shadow);
                                    }

                                    .stat-card::before {
                                        content: '';
                                        position: absolute;
                                        top: 0;
                                        left: 0;
                                        right: 0;
                                        height: 4px;
                                    }

                                    .stat-card:hover {
                                        transform: translateY(-5px);
                                        box-shadow: 0 12px 32px var(--shadow);
                                        border-color: var(--primary);
                                    }

                                    .stat-icon {
                                        font-size: 2.5rem;
                                        margin-bottom: 15px;
                                    }

                                    .stat-number {
                                        font-size: 2.5rem;
                                        font-weight: bold;
                                        margin-bottom: 10px;
                                    }

                                    .stat-label {
                                        color: var(--muted-text);
                                        font-size: 0.95rem;
                                        font-weight: 500;
                                    }

                                    .stat-total::before {
                                        background: linear-gradient(90deg, var(--primary), var(--primary-light));
                                    }

                                    .stat-total .stat-icon,
                                    .stat-total .stat-number {
                                        color: var(--primary);
                                    }

                                    .stat-available::before {
                                        background: linear-gradient(90deg, var(--success), #66BB6A);
                                    }

                                    .stat-available .stat-icon,
                                    .stat-available .stat-number {
                                        color: var(--success);
                                    }

                                    .stat-occupied::before {
                                        background: linear-gradient(90deg, var(--danger), #E57373);
                                    }

                                    .stat-occupied .stat-icon,
                                    .stat-occupied .stat-number {
                                        color: var(--danger);
                                    }

                                    .stat-pending::before {
                                        background: linear-gradient(90deg, var(--warning), #FFB74D);
                                    }

                                    .stat-pending .stat-icon,
                                    .stat-pending .stat-number {
                                        color: var(--warning);
                                    }

                                    .stat-revenue::before {
                                        background: linear-gradient(90deg, #42a5f5, var(--primary-dark));
                                    }

                                    .stat-revenue .stat-icon,
                                    .stat-revenue .stat-number {
                                        color: #42a5f5;
                                    }



                                    .search-form {
                                        max-width: 1200px;
                                        margin: 0 auto;
                                    }

                                    .search-form h3 {
                                        font-size: 1.4rem;
                                        color: var(--primary);
                                        margin-bottom: 20px;
                                        font-weight: 700;
                                        display: flex;
                                        align-items: center;
                                        gap: 10px;
                                    }

                                    .search-row {
                                        display: flex;
                                        align-items: flex-end;
                                        gap: 20px;
                                        flex-wrap: wrap;
                                    }

                                    .form-group {
                                        display: flex;
                                        flex-direction: column;
                                        gap: 6px;
                                        flex: 1;
                                        min-width: 180px;
                                    }

                                    .form-group label {
                                        color: var(--text);
                                        font-weight: 600;
                                        font-size: 0.95rem;
                                    }

                                    .form-group select {
                                        padding: 12px 16px;
                                        border-radius: 10px;
                                        border: 2px solid var(--card-border);
                                        background: white;
                                        color: var(--text);
                                        font-weight: 600;
                                        font-family: 'Sarabun', sans-serif;
                                        transition: all 0.3s ease;
                                        cursor: pointer;
                                        width: 100%;
                                    }

                                    .form-group select:focus {
                                        outline: none;
                                        border-color: var(--primary);
                                        box-shadow: 0 0 0 3px rgba(92, 169, 233, 0.1);
                                    }

                                    .search-btn {
                                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                                        color: white;
                                        border: none;
                                        padding: 12px 32px;
                                        border-radius: 10px;
                                        font-weight: 700;
                                        font-family: 'Sarabun', sans-serif;
                                        cursor: pointer;
                                        transition: all 0.3s ease;
                                        box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 8px;
                                        white-space: nowrap;
                                        height: 48px;
                                    }

                                    .search-btn:hover {
                                        box-shadow: 0 6px 16px rgba(74, 144, 226, 0.4);
                                        transform: translateY(-2px);
                                    }


                                    .table-container {
                                        flex: 1;
                                        padding: 28px 48px;
                                        background: var(--bg);
                                    }

                                    .table-header {
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        margin-bottom: 28px;
                                        flex-wrap: wrap;
                                        gap: 15px;
                                        padding-bottom: 20px;
                                        border-bottom: 2px solid var(--border);
                                    }

                                    .table-header h2 {
                                        color: var(--primary);
                                        font-size: 1.6rem;
                                        font-weight: 700;
                                        display: flex;
                                        align-items: center;
                                        gap: 12px;
                                    }

                                    .table-info {
                                        color: var(--muted-text);
                                        font-size: 1rem;
                                        font-weight: 500;
                                    }

                                    table {
                                        width: 100%;
                                        border-collapse: collapse;
                                    }

                                    thead tr {
                                        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                                    }

                                    th {
                                        padding: 18px 15px;
                                        text-align: center;
                                        font-weight: 600;
                                        color: var(--text-light);
                                        text-transform: uppercase;
                                        letter-spacing: 0.5px;
                                        font-size: 0.9rem;
                                    }

                                    td {
                                        padding: 16px 15px;
                                        text-align: center;
                                        border-bottom: 1px solid var(--border);
                                        color: var(--text);
                                    }

                                    tbody tr {
                                        transition: all 0.3s ease;
                                        background: var(--bg);
                                    }

                                    tbody tr:hover {
                                        background: var(--accent);
                                        transform: scale(1.01);
                                    }

                                    .room-number {
                                        font-weight: 700;
                                        color: var(--primary);
                                        font-size: 1.1rem;
                                    }

                                    .room-type {
                                        color: var(--text);
                                        font-weight: 500;
                                    }

                                    .price {
                                        font-weight: 600;
                                        color: var(--success);
                                        font-size: 1.05rem;
                                    }


                                    .status-badge {
                                        padding: 7px 18px;
                                        border-radius: 20px;
                                        font-size: 0.88rem;
                                        font-weight: 600;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 8px;
                                    }

                                    .status-available {
                                        background: linear-gradient(135deg, var(--success), #66BB6A);
                                        color: var(--text-light);
                                        box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
                                    }

                                    .status-occupied {
                                        background: linear-gradient(135deg, var(--danger), #E57373);
                                        color: var(--text-light);
                                        box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
                                    }

                                    .deposit-status {
                                        font-size: 0.82rem;
                                        margin-top: 6px;
                                        display: inline-block;
                                        font-weight: 600;
                                    }

                                    .deposit-status.approved {
                                        color: var(--success);
                                    }

                                    .deposit-status.pending {
                                        color: var(--warning);
                                    }


                                    .action-buttons {
                                        display: flex;
                                        gap: 8px;
                                        justify-content: center;
                                        flex-wrap: wrap;
                                    }

                                    .action-btn {
                                        padding: 9px 18px;
                                        border: none;
                                        border-radius: 10px;
                                        font-size: 0.88rem;
                                        font-weight: 600;
                                        font-family: 'Sarabun', sans-serif;
                                        cursor: pointer;
                                        transition: all 0.3s ease;
                                        text-decoration: none;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 8px;
                                    }

                                    .btn-add {
                                        background: linear-gradient(135deg, var(--success), #66BB6A);
                                        color: var(--text-light);
                                        box-shadow: 0 3px 10px rgba(76, 175, 80, 0.3);
                                    }

                                    .btn-edit-invoice {
                                        background: linear-gradient(135deg, #42a5f5, var(--primary-dark));
                                        color: var(--text-light);
                                        box-shadow: 0 3px 10px rgba(66, 165, 245, 0.3);
                                    }

                                    .btn-edit {
                                        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                                        color: var(--text-light);
                                        box-shadow: 0 3px 10px var(--shadow);
                                    }

                                    .btn-delete {
                                        background: linear-gradient(135deg, var(--danger), #E57373);
                                        color: var(--text-light);
                                        box-shadow: 0 3px 10px rgba(244, 67, 54, 0.3);
                                    }

                                    .btn-view {
                                        background: linear-gradient(135deg, var(--warning), #FFB74D);
                                        color: var(--text-light);
                                        box-shadow: 0 3px 10px rgba(255, 152, 0, 0.3);
                                    }

                                    .btn-disabled {
                                        background: #ccc;
                                        color: var(--muted-text);
                                        cursor: not-allowed;
                                        opacity: 0.6;
                                    }

                                    .action-btn:not(.btn-disabled):hover {
                                        transform: translateY(-2px);
                                        box-shadow: 0 5px 16px var(--shadow);
                                    }

                                    .rooms-grid {
                                        display: grid;
                                        grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
                                        gap: 20px;
                                        padding: 18px 8px;
                                    }

                                    .room-card {
                                        width: 100%;
                                        background: var(--bg);
                                        border-radius: 16px;
                                        border: 2px solid var(--card-border);
                                        box-shadow: 0 8px 24px rgba(92, 169, 233, 0.12);
                                        overflow: hidden;
                                        display: flex;
                                        flex-direction: column;
                                        transition: all 0.3s ease;
                                    }

                                    .room-card:hover {
                                        transform: translateY(-8px);
                                        box-shadow: 0 12px 32px rgba(92, 169, 233, 0.2);
                                        border-color: var(--primary);
                                    }

                                    .room-image-container {
                                        height: 240px;
                                        background: linear-gradient(135deg, var(--accent) 0%, var(--hover-bg) 100%);
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        overflow: hidden;
                                        position: relative;
                                    }

                                    .room-image {
                                        width: 100%;
                                        height: 100%;
                                        object-fit: cover;
                                        transition: transform .4s ease;
                                    }

                                    .room-card:hover .room-image {
                                        transform: scale(1.06);
                                    }

                                    .no-image {
                                        display: flex;
                                        flex-direction: column;
                                        align-items: center;
                                        justify-content: center;
                                        gap: 12px;
                                        color: var(--primary);
                                    }

                                    .no-image i {
                                        font-size: 3rem;
                                        opacity: 0.5;
                                    }

                                    .no-image-text {
                                        font-weight: 600;
                                        color: var(--muted-text);
                                    }

                                    .room-info {
                                        padding: 20px;
                                        background: transparent;
                                        color: var(--text);
                                        display: flex;
                                        flex-direction: column;
                                        gap: 14px;
                                    }

                                    .room-number-badge {
                                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                                        color: white;
                                        padding: 10px 16px;
                                        border-radius: 10px;
                                        font-weight: 700;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 8px;
                                        font-size: 1.05rem;
                                        box-shadow: 0 4px 12px rgba(74, 144, 226, 0.25);
                                    }

                                    .room-detail-row {
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        padding: 8px 0;
                                        border-bottom: 1px solid var(--accent);
                                    }

                                    .room-detail-row:last-of-type {
                                        border-bottom: none;
                                    }

                                    .detail-label {
                                        color: var(--muted-text);
                                        font-size: 0.95rem;
                                        font-weight: 600;
                                    }

                                    .detail-value {
                                        color: var(--text);
                                        font-weight: 700;
                                        font-size: 1.05rem;
                                    }

                                    .deposit-status {
                                        padding: 4px 10px;
                                        border-radius: 12px;
                                        font-size: 0.85rem;
                                        font-weight: 600;
                                    }

                                    .deposit-status.pending {
                                        background: #FEF3C7;
                                        color: #F59E0B;
                                        border: 1px solid #F59E0B;
                                    }

                                    .deposit-status.approved {
                                        background: #D4F4DD;
                                        color: #22C55E;
                                        border: 1px solid #22C55E;
                                    }

                                    .action-buttons {
                                        display: flex;
                                        flex-direction: column;
                                        gap: 8px;
                                        margin-top: 8px;
                                    }

                                    .view-btn {
                                        display: inline-block;
                                        text-align: center;
                                        padding: 12px 16px;
                                        border-radius: 10px;
                                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                                        color: white;
                                        text-decoration: none;
                                        font-weight: 700;
                                        transition: all 0.3s ease;
                                        box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
                                        border: none;
                                        cursor: pointer;
                                        width: 100%;
                                    }

                                    .view-btn:hover {
                                        box-shadow: 0 6px 16px rgba(74, 144, 226, 0.4);
                                        transform: translateY(-2px);
                                    }

                                    .empty-state {
                                        padding: 80px 20px;
                                        text-align: center;
                                        color: var(--muted-text);
                                    }

                                    .empty-state i {
                                        font-size: 4rem;
                                        color: var(--primary);
                                        opacity: 0.3;
                                        margin-bottom: 20px;
                                    }

                                    .empty-state h3 {
                                        color: var(--text);
                                        margin: 16px 0 8px;
                                        font-size: 1.4rem;
                                    }

                                    .empty-state p {
                                        color: var(--muted-text);
                                    }


                                    .loading {
                                        display: none;
                                        position: fixed;
                                        top: 0;
                                        left: 0;
                                        width: 100%;
                                        height: 100%;
                                        background: rgba(0, 0, 0, 0.9);
                                        z-index: 1000;
                                        justify-content: center;
                                        align-items: center;
                                    }

                                    .spinner {
                                        width: 60px;
                                        height: 60px;
                                        border: 6px solid var(--accent);
                                        border-top: 6px solid var(--primary);
                                        border-radius: 50%;
                                        animation: spin 1s linear infinite;
                                    }

                                    @keyframes spin {
                                        0% {
                                            transform: rotate(0deg);
                                        }

                                        100% {
                                            transform: rotate(360deg);
                                        }
                                    }

                                    .toast {
                                        position: fixed;
                                        top: 20px;
                                        right: 20px;
                                        background: var(--bg);
                                        padding: 16px 22px;
                                        border-radius: 12px;
                                        box-shadow: 0 6px 20px var(--shadow);
                                        z-index: 1001;
                                        display: none;
                                        animation: slideInRight 0.3s ease;
                                        border: 2px solid var(--border);
                                        color: var(--text);
                                        max-width: 400px;
                                        font-weight: 500;
                                    }

                                    .toast.success {
                                        border-left: 5px solid var(--success);
                                    }

                                    .toast.error {
                                        border-left: 5px solid var(--danger);
                                    }

                                    @keyframes slideInRight {
                                        from {
                                            transform: translateX(100%);
                                            opacity: 0;
                                        }

                                        to {
                                            transform: translateX(0);
                                            opacity: 1;
                                        }
                                    }


                                    @media (max-width: 768px) {
                                        .header {
                                            font-size: 1.8rem;
                                            padding: 20px;
                                        }

                                        .top-bar {
                                            flex-direction: column;
                                            gap: 15px;
                                            text-align: center;
                                        }

                                        .stats-container {
                                            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                                        }

                                        .rooms-grid {
                                            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                                        }

                                        .nav a {
                                            min-width: 100%;
                                        }

                                        .search-form form {
                                            flex-direction: column;
                                        }

                                        .form-group {
                                            width: 100%;
                                        }

                                        table {
                                            font-size: 0.85rem;
                                        }

                                        th,
                                        td {
                                            padding: 12px 8px;
                                        }

                                        .action-buttons {
                                            flex-direction: column;
                                        }

                                        .action-btn {
                                            width: 100%;
                                            justify-content: center;
                                        }
                                    }

                                    @media (max-width: 480px) {
                                        .rooms-grid {
                                            grid-template-columns: 1fr;
                                            gap: 14px;
                                            padding: 12px;
                                        }
                                    }

.btn-edit-profile {
    background: linear-gradient(135deg, #5CA9E9, #4A90E2);
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 10px;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
    font-family: "Sarabun", sans-serif;
    font-size: 0.95rem;
    text-decoration: none;
    box-shadow: 0 2px 8px rgba(92, 169, 233, 0.3);
}

.btn-edit-profile:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(92, 169, 233, 0.4);
    background: linear-gradient(135deg, #4A90E2, #357ABD);
}
                                </style>
                            </head>

                            <body>
                                <div class="loading" id="loading">
                                    <div class="spinner"></div>
                                </div>

                                <div id="toast" class="toast">
                                    <div id="toast-message"></div>
                                </div>

                                <div class="page-container">
                                    <div class="header">
                                        <h1>
                                            <i class="fas fa-building"></i>
                                            ThanaChok Place
                                        </h1>
                                        <div class="nav-menu">
                                            <a href="OwnerHome" class="nav-link active">
                                                <i class="fas fa-home"></i> หน้าหลัก
                                            </a>
                                            <a href="OViewReserve" class="nav-link">
                                                <i class="fas fa-list"></i> รายการเช่า
                                            </a>
                                            <a href="ListReservations" class="nav-link">
                                                <i class="fas fa-clipboard-list"></i> รายการจอง
                                            </a>
                                            <a href="ListReturnRoom" class="nav-link">
                                                <i class="fas fa-clipboard-check"></i> คำขอคืนห้อง
                                            </a>
                                            <a href="ManageUtilityRates" class="nav-link">
                                                <i class="fas fa-cogs"></i> ตั้งค่าหน่วย
                                            </a>
                                            <a href="AddRoom" class="nav-link">
                                                <i class="fas fa-plus"></i> เพิ่มห้อง
                                            </a>
                                        </div>
                                        <div class="user-section">
                                            <div class="user-info">
                                                <i class="fas fa-user-circle"></i>
                                                <span>${loginManager.email}</span>
                                            </div>
                                            <a href="EditManager" class="btn-edit-profile" style="margin-left:10px;">
                                                <i class="fas fa-user-edit"></i> แก้ไขข้อมูล
                                            </a>
                                            <form action="Logout" method="post" style="display: inline">
                                                <button type="submit" class="logout-btn">
                                                    <i class="fas fa-sign-out-alt"></i>
                                                    ออกจากระบบ
                                                </button>
                                            </form>
                                        </div>
                                    </div>

                                    <div class="stats-container">
                                        <div class="stat-card stat-total">
                                            <div class="stat-icon">
                                                <i class="fas fa-door-open"></i>
                                            </div>
                                            <div class="stat-number" id="totalRooms">
                                                <c:set var="totalRooms" value="${roomList.size()}" />
                                                ${totalRooms}
                                            </div>
                                            <div class="stat-label">ห้องทั้งหมด</div>
                                        </div>

                                        <div class="stat-card stat-available">
                                            <div class="stat-icon">
                                                <i class="fas fa-check-circle"></i>
                                            </div>
                                            <div class="stat-number" id="availableRooms">
                                                <c:set var="availableCount" value="0" />
                                                <c:forEach var="room" items="${roomList}">
                                                    <c:if test="${room.roomStatus == 'ว่าง'}">
                                                        <c:set var="availableCount" value="${availableCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${availableCount}
                                            </div>
                                            <div class="stat-label">ห้องว่าง</div>
                                        </div>

                                        <div class="stat-card stat-occupied">
                                            <div class="stat-icon">
                                                <i class="fas fa-times-circle"></i>
                                            </div>
                                            <div class="stat-number" id="occupiedRooms">
                                                <c:set var="occupiedCount" value="0" />
                                                <c:forEach var="room" items="${roomList}">
                                                    <c:if test="${room.roomStatus == 'ไม่ว่าง'}">
                                                        <c:set var="occupiedCount" value="${occupiedCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${occupiedCount}
                                            </div>
                                            <div class="stat-label">ห้องไม่ว่าง</div>
                                        </div>

                                        <div class="stat-card stat-pending">
                                            <div class="stat-icon">
                                                <i class="fas fa-clock"></i>
                                            </div>
                                            <div class="stat-number">
                                                <c:set var="pendingCount" value="0" />
                                                <c:forEach var="room" items="${roomList}">
                                                    <c:if
                                                        test="${room.roomStatus == 'ไม่ว่าง' && roomDepositStatus[room.roomID] == 'รอดำเนินการ'}">
                                                        <c:set var="pendingCount" value="${pendingCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${pendingCount}
                                            </div>
                                            <div class="stat-label">รอการอนุมัติ</div>
                                        </div>

                                        <div class="stat-card stat-revenue">
                                            <div class="stat-icon">
                                                <i class="fas fa-money-bill-wave"></i>
                                            </div>
                                            <div class="stat-number">
                                                <c:set var="totalRevenue" value="0" />
                                                <c:forEach var="room" items="${roomList}">
                                                    <c:if test="${room.roomStatus == 'ไม่ว่าง'}">
                                                        <c:set var="totalRevenue"
                                                            value="${totalRevenue + room.roomPrice}" />
                                                    </c:if>
                                                </c:forEach>
                                                ฿
                                                <fmt:formatNumber value="${totalRevenue}" groupingUsed="true" />
                                            </div>
                                            <div class="stat-label">รายได้ต่อเดือน</div>
                                        </div>
                                    </div>
                                    <div class="search-section">
                                        <div class="search-form">
                                            <h3>
                                                <i class="fas fa-search"></i>
                                                ค้นหาและกรองห้องพัก
                                            </h3>
                                            <form method="get" action="OwnerHome" id="searchForm">
                                                <div class="search-row">
                                                    <div class="form-group">
                                                        <label for="floor">ชั้น:</label>
                                                        <select name="floor" id="floor">
                                                            <option value="">ทั้งหมด</option>
                                                            <c:forEach var="i" begin="1" end="5">
                                                                <option value="${i}" ${param.floor==i ? 'selected' : ''
                                                                    }>ชั้น ${i}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="status">สถานะ:</label>
                                                        <select name="status" id="status">
                                                            <option value="">ทั้งหมด</option>
                                                            <option value="ว่าง" ${param.status=='ว่าง' ? 'selected'
                                                                : '' }>ว่าง</option>
                                                            <option value="ไม่ว่าง" ${param.status=='ไม่ว่าง'
                                                                ? 'selected' : '' }>ไม่ว่าง</option>
                                                        </select>
                                                    </div>

                                                    <button type="submit" class="search-btn">
                                                        <i class="fas fa-search"></i>
                                                        ค้นหา
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                    <div class="table-container">
                                        <div class="table-header">
                                            <h2>
                                                <i class="fas fa-list"></i>
                                                รายการห้องพัก
                                            </h2>
                                        </div>

                                        <c:choose>
                                            <c:when test="${empty roomList}">
                                                <div class="empty-state">
                                                    <i class="fas fa-search"></i>
                                                    <h3>ไม่พบห้องพัก</h3>
                                                    <p>ลองเปลี่ยนเงื่อนไขการค้นหาหรือเพิ่มห้องใหม่</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="rooms-grid">
                                                    <c:forEach var="room" items="${roomList}">
                                                        <div class="room-card">
                                                            <div class="room-image-container">
                                                                <c:choose>
                                                                    <c:when test="${not empty room.roomNumberImage}">
                                                                        <img src="${pageContext.request.contextPath}/RoomImage?roomId=${room.roomID}&imageType=number"
                                                                            alt="ห้อง ${room.roomNumber}"
                                                                            class="room-image"
                                                                            onerror="this.parentElement.innerHTML='<div class=\'no-image\'><i class=\'fas fa-image\'></i><span class=\'no-image-text\'>ไม่มีรูปภาพ</span></div>';">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="no-image">
                                                                            <i class="fas fa-image"></i>
                                                                            <span
                                                                                class="no-image-text">ไม่มีรูปภาพ</span>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>

                                                            <div class="room-info">
                                                                <div class="room-number-badge">
                                                                    <i class="fas fa-door-open"></i>
                                                                    ห้อง ${room.roomNumber}
                                                                </div>

                                                                <div class="room-detail-row">
                                                                    <span class="detail-label">
                                                                        <i class="fas fa-home"></i> ประเภทห้อง
                                                                    </span>
                                                                    <span class="detail-value">${room.roomtype}</span>
                                                                </div>

                                                                <div class="room-detail-row">
                                                                    <span class="detail-label">
                                                                        <i class="fas fa-money-bill-wave"></i> ราคา
                                                                    </span>
                                                                    <span class="detail-value">฿
                                                                        <fmt:formatNumber value="${room.roomPrice}"
                                                                            groupingUsed="true" />
                                                                    </span>
                                                                </div>

                                                                <div class="room-detail-row">
                                                                    <span class="detail-label">
                                                                        <i class="fas fa-info-circle"></i> สถานะ
                                                                    </span>
                                                                    <span
                                                                        class="status-badge ${room.roomStatus == 'ว่าง' ? 'status-available' : 'status-occupied'}">
                                                                        <i
                                                                            class="fas ${room.roomStatus == 'ว่าง' ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                                                        ${room.roomStatus}
                                                                    </span>
                                                                </div>

                                                                <c:if test="${room.roomStatus == 'ไม่ว่าง'}">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${roomDepositStatus[room.roomID] == 'รอคืนห้อง'}">
                                                                            <div class="room-detail-row">
                                                                                <span class="detail-label">
                                                                                    <i class="fas fa-door-open"></i>
                                                                                    สถานะเพิ่มเติม
                                                                                </span>
                                                                                <span class="deposit-status pending"
                                                                                    style="color: #ff4444;">
                                                                                    รอคืนห้อง
                                                                                </span>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:when
                                                                            test="${roomDepositStatus[room.roomID] == 'รอดำเนินการ'}">
                                                                            <div class="room-detail-row">
                                                                                <span class="detail-label">
                                                                                    <i class="fas fa-clock"></i>
                                                                                    สถานะเพิ่มเติม
                                                                                </span>
                                                                                <span class="deposit-status pending">
                                                                                    รอดำเนินการ
                                                                                </span>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:when
                                                                            test="${roomDepositStatus[room.roomID] == 'เสร็จสมบูรณ์'}">
                                                                            <div class="room-detail-row">
                                                                                <span class="detail-label">
                                                                                    <i class="fas fa-check-circle"></i>
                                                                                    สถานะเพิ่มเติม
                                                                                </span>
                                                                                <span class="deposit-status approved">
                                                                                    เสร็จสมบูรณ์
                                                                                </span>
                                                                            </div>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </c:if>

                                                                <div class="action-buttons">
                                                                    <c:if test="${room.roomStatus == 'ไม่ว่าง'}">
                                                                        <a href="ManagerAddInvoice?roomID=${room.roomID}"
                                                                            class="view-btn"
                                                                            style="background:linear-gradient(135deg, #22C55E, #16A34A);">
                                                                            <i class="fas fa-plus"></i> เพิ่มบิล
                                                                        </a>
                                                                        <a href="EditInvoice?roomID=${room.roomID}"
                                                                            class="view-btn"
                                                                            style="background:linear-gradient(135deg, #F59E0B, #D97706);">
                                                                            <i class="fas fa-file-invoice"></i> แก้ไขบิล
                                                                        </a>

                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${roomDepositStatus[room.roomID] == 'รอคืนห้อง'}">
                                                                                <a href="ListReturnRoom"
                                                                                    class="view-btn"
                                                                                    style="background: linear-gradient(135deg, #9c27b0, #7b1fa2);">
                                                                                    <i class="fas fa-door-open"></i>
                                                                                    อนุมัติการคืนห้อง
                                                                                </a>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${roomDepositStatus[room.roomID] == 'รอดำเนินการ'}">
                                                                                <a href="OViewReserve" class="view-btn"
                                                                                    style="background: linear-gradient(135deg, #3B82F6, #2563EB);">
                                                                                    <i
                                                                                        class="fas fa-clipboard-check"></i>
                                                                                    อนุมัติการจอง
                                                                                </a>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${roomDepositStatus[room.roomID] == 'ชำระแล้ว'}">
                                                                                <button class="view-btn"
                                                                                    style="background:linear-gradient(135deg, #FF6B6B, #EE5A6F);"
                                                                                    onclick="showReturnRoomModal(${room.roomID}, '${room.roomNumber}', '${roomRentId[room.roomID]}')">
                                                                                    <i class="fas fa-sign-out-alt"></i>
                                                                                    คืนห้อง
                                                                                </button>
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </c:if>

                                                                    <a href="ViewRoomHistory?roomId=${room.roomID}"
                                                                        class="view-btn"
                                                                        style="background:linear-gradient(135deg, #9C27B0, #BA68C8);">
                                                                        <i class="fas fa-history"></i> ดูประวัติการเข้าพัก
                                                                    </a>

                                                                    <a href="editRoom?id=${room.roomID}"
                                                                        class="view-btn"
                                                                        style="background:linear-gradient(135deg, #4A90E2, #5CA9E9);">
                                                                        <i class="fas fa-edit"></i> แก้ไขข้อมูล
                                                                    </a>

                                                                    <c:if test="${room.roomStatus == 'ว่าง'}">
                                                                        <button class="view-btn"
                                                                            style="background:linear-gradient(135deg, #EF4444, #DC2626);"
                                                                            onclick="confirmDelete(${room.roomID}, '${room.roomNumber}')">
                                                                            <i class="fas fa-trash"></i> ลบห้อง
                                                                        </button>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div id="returnRoomModal"
                                    style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.7); z-index:9999; justify-content:center; align-items:center;">
                                    <div
                                        style="background:white; padding:40px; border-radius:20px; max-width:500px; width:90%; box-shadow:0 10px 40px rgba(0,0,0,0.3);">
                                        <h3
                                            style="color:var(--primary); margin-bottom:20px; font-size:1.8rem; display:flex; align-items:center; gap:12px;">
                                            <i class="fas fa-sign-out-alt"></i>
                                            คืนห้อง <span id="modalRoomNumber" style="color:var(--danger);"></span>
                                        </h3>
                                        <form id="returnRoomForm" method="post" action="ManagerForceReturnRoom">
                                            <input type="hidden" id="modalRentId" name="rentId">
                                            <input type="hidden" id="modalRoomNumberInput" name="roomNumber">

                                            <div style="margin-bottom:25px;">
                                                <label
                                                    style="display:block; margin-bottom:10px; font-weight:700; color:var(--text); font-size:1.1rem;">
                                                    <i class="fas fa-sticky-note"></i> หมายเหตุ / เหตุผลในการคืนห้อง:
                                                </label>
                                                <textarea name="notes" id="returnNotes" required
                                                    style="width:100%; min-height:150px; padding:15px; border:2px solid var(--card-border); border-radius:12px; font-family:'Sarabun',sans-serif; font-size:1rem; resize:vertical;"
                                                    placeholder="กรุณากรอกเหตุผลหรือหมายเหตุในการคืนห้อง...&#10;เช่น: ผู้เช่าขอยกเลิกสัญญา, ย้ายออก, ฯลฯ"></textarea>
                                                <small style="color:var(--muted-text); display:block; margin-top:8px;">
                                                    <i class="fas fa-info-circle"></i>
                                                    ข้อมูลนี้จะถูกบันทึกไว้เพื่อการตรวจสอบในภายหลัง
                                                </small>
                                            </div>

                                            <div style="display:flex; gap:12px; justify-content:flex-end;">
                                                <button type="button" onclick="closeReturnRoomModal()"
                                                    style="padding:12px 28px; border:2px solid var(--card-border); background:white; color:var(--text); border-radius:10px; cursor:pointer; font-weight:700; font-family:'Sarabun',sans-serif; font-size:1rem;">
                                                    <i class="fas fa-times"></i> ยกเลิก
                                                </button>
                                                <button type="submit"
                                                    style="padding:12px 28px; border:none; background:linear-gradient(135deg, #EF4444, #DC2626); color:white; border-radius:10px; cursor:pointer; font-weight:700; font-family:'Sarabun',sans-serif; font-size:1rem; box-shadow:0 4px 12px rgba(239,68,68,0.3);">
                                                    <i class="fas fa-check"></i> ยืนยันการคืนห้อง
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <script>
                                    var successMessage = '<c:out value="${message}" escapeXml="false" />';
                                    var errorMessage = '<c:out value="${error}" escapeXml="false" />';

                                    function createParticles() {
                                        const particles = document.getElementById('particles');
                                        if (!particles) return; 
                                        const particleCount = 50;
                                        for (let i = 0; i < particleCount; i++) {
                                            const particle = document.createElement('div');
                                            particle.className = 'particle';
                                            particle.style.left = Math.random() * 100 + '%';
                                            particle.style.animationDelay = Math.random() * 8 + 's';
                                            particle.style.animationDuration = (Math.random() * 3 + 5) + 's';
                                            particles.appendChild(particle);
                                        }
                                    }

                                    function showToast(message, type = 'success') {
                                        const toast = document.getElementById('toast');
                                        const toastMessage = document.getElementById('toast-message');
                                        toastMessage.textContent = message;
                                        toast.className = `toast ${type}`;
                                        toast.style.display = 'block';
                                        setTimeout(() => { toast.style.display = 'none'; }, 5000);
                                    }

                                    function showReturnRoomModal(roomID, roomNumber, rentId) {
                                        if (!rentId || rentId === '' || rentId === 'undefined' || rentId === 'null') {
                                            showToast('ข้อผิดพลาด: ไม่พบข้อมูลการเช่า', 'error');
                                            return;
                                        }

                                        document.getElementById('modalRoomNumber').textContent = roomNumber;
                                        document.getElementById('modalRentId').value = rentId;
                                        document.getElementById('modalRoomNumberInput').value = roomNumber;
                                        document.getElementById('returnNotes').value = '';
                                        document.getElementById('returnRoomModal').style.display = 'flex';
                                    }

                                    function closeReturnRoomModal() {
                                        document.getElementById('returnRoomModal').style.display = 'none';
                                    }

                                    document.getElementById('returnRoomForm').addEventListener('submit', function (e) {
                                        const notes = document.getElementById('returnNotes').value.trim();
                                        if (notes === '') {
                                            e.preventDefault();
                                            showToast('กรุณากรอกหมายเหตุ', 'error');
                                            return;
                                        }
                                        document.getElementById('loading').style.display = 'flex';
                                    });

                                    function confirmDelete(roomID, roomNumber) {

                                        if (!roomID || roomID === '' || roomID === 'undefined' || roomID === 'null') {
                                            showToast('ข้อผิดพลาด: ไม่พบรหัสห้อง', 'error');
                                            console.error('Invalid roomID:', roomID);
                                            return;
                                        }

                                        if (confirm(`⚠️ คำเตือน!\n\nคุณต้องการลบห้อง ${roomNumber} ใช่หรือไม่?\n\nการดำเนินการนี้ไม่สามารถยกเลิกได้`)) {
                                            document.getElementById('loading').style.display = 'flex';

                                            const deleteUrl = 'deleteRoom?id=' + roomID;
                                            console.log('Navigating to:', deleteUrl);

                                            window.location.href = deleteUrl;
                                        }
                                    }

                                    function clearFilters() {
                                        document.getElementById('floor').value = '';
                                        document.getElementById('status').value = '';
                                        document.getElementById('searchForm').submit();
                                    }

                                    document.getElementById('searchForm').addEventListener('submit', function () {
                                        document.getElementById('loading').style.display = 'flex';
                                    });

                                    window.addEventListener('load', function () {
                                        createParticles();

                                        if (successMessage) {
                                            setTimeout(function () { showToast(successMessage, "success"); }, 500);
                                        }

                                        if (errorMessage) {
                                            setTimeout(function () { showToast(errorMessage, "error"); }, 500);
                                        }

                                        setTimeout(function () { document.getElementById('loading').style.display = 'none'; }, 1000);

                                        document.body.style.opacity = '0';
                                        document.body.style.transition = 'opacity 0.5s ease-in-out';
                                        setTimeout(function () { document.body.style.opacity = '1'; }, 100);
                                    }); document.querySelectorAll('.action-btn:not(.btn-disabled)').forEach(btn => {
                                        btn.addEventListener('click', function (e) {
                                            this.style.transform = 'scale(0.95)';
                                            setTimeout(() => { this.style.transform = ''; }, 150);
                                        });
                                    });

                                    document.addEventListener('DOMContentLoaded', function () {
                                        document.querySelectorAll('tbody tr').forEach(row => {
                                            const depositStatus = row.querySelector('.deposit-status');
                                            if (depositStatus && depositStatus.textContent.includes('รอดำเนินการ')) {
                                                row.style.boxShadow = '0 0 0 2px rgba(255, 167, 38, 0.3)';
                                                row.style.backgroundColor = 'rgba(255, 167, 38, 0.05)';
                                            }
                                        });
                                    });

                                    document.addEventListener('keydown', function (e) {
                                        if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                                            e.preventDefault();
                                            document.getElementById('floor').focus();
                                        }
                                        if (e.key === 'Escape') {
                                            clearFilters();
                                        }
                                    });
                                </script>
                            </body>
                            </html>