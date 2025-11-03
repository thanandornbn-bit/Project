<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ page session="true" %>
            <%@ page import="com.springmvc.model.Member" %>
                <%@ page import="java.util.*" %>
                    <%@ page import="com.springmvc.model.*" %>

                        <% Member loginMember=(Member) session.getAttribute("loginMember"); if (loginMember==null) {
                            response.sendRedirect("Login"); return; } %>

                            <!DOCTYPE html>
                            <html lang="th">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>ThanaChok Place - หน้าหลักสมาชิก</title>
                                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                                    rel="stylesheet">
                                <link
                                    href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&display=swap"
                                    rel="stylesheet">
                                <style>
                                    * {
                                        margin: 0;
                                        padding: 0;
                                        box-sizing: border-box;
                                    }

                                    :root {
                                        --bg: #FFFFFF;
                                        --muted-bg: #F0F7FF;
                                        --primary: #5CA9E9;
                                        --primary-dark: #4A90E2;
                                        --accent: #E3F2FD;
                                        --text: #1E3A5F;
                                        --muted-text: #5B7A9D;
                                        --card-border: #D1E8FF;
                                        --hover-bg: #E8F4FF;
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

                                    .rental-alert {
                                        background: linear-gradient(135deg, #FFF3CD, #FFEAA7);
                                        border: 2px solid #F7C948;
                                        color: #856404;
                                        padding: 20px 32px;
                                        margin: 20px 48px;
                                        border-radius: 12px;
                                        text-align: center;
                                        display: none;
                                        box-shadow: 0 3px 15px rgba(247, 201, 72, 0.3);
                                    }

                                    .rental-alert.show {
                                        display: block;
                                        animation: slideDown 0.5s ease;
                                    }

                                    .rental-alert .alert-icon {
                                        font-size: 2rem;
                                        margin-bottom: 15px;
                                        color: #F7C948;
                                    }

                                    .rental-alert .alert-content {
                                        font-size: 1.1rem;
                                        line-height: 1.5;
                                    }

                                    @keyframes slideDown {
                                        from {
                                            opacity: 0;
                                            transform: translateY(-20px);
                                        }

                                        to {
                                            opacity: 1;
                                            transform: translateY(0);
                                        }
                                    }

                                    .table-container {
                                        flex: 1;
                                        padding: 28px 48px;
                                        background: var(--bg);
                                    }

                                    .table-header {
                                        margin-bottom: 24px;
                                    }

                                    .table-header h2 {
                                        color: var(--text);
                                        font-size: 1.8rem;
                                        margin-bottom: 10px;
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

                                    .status-badge {
                                        padding: 8px 14px;
                                        border-radius: 20px;
                                        font-weight: 700;
                                        font-size: 0.9rem;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 6px;
                                    }

                                    .status-available {
                                        background: #D4F4DD;
                                        color: #22C55E;
                                        border: 2px solid #22C55E;
                                    }

                                    .status-occupied {
                                        background: #FFE4E6;
                                        color: #EF4444;
                                        border: 2px solid #EF4444;
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
                                        margin-top: 8px;
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

                                    .loading {
                                        display: none;
                                        position: fixed;
                                        inset: 0;
                                        align-items: center;
                                        justify-content: center;
                                        background: rgba(255, 255, 255, 0.9);
                                        z-index: 2000;
                                    }

                                    .spinner {
                                        width: 50px;
                                        height: 50px;
                                        border: 4px solid var(--accent);
                                        border-top: 4px solid var(--primary);
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
                                        background: white;
                                        padding: 16px 24px;
                                        border-radius: 12px;
                                        box-shadow: 0 8px 24px rgba(74, 144, 226, 0.2);
                                        border: 2px solid var(--accent);
                                        display: none;
                                        z-index: 3000;
                                    }

                                    .toast.show {
                                        display: block;
                                        animation: slideIn 0.3s ease;
                                    }

                                    .toast.success {
                                        border-color: #22C55E;
                                    }

                                    .toast.error {
                                        border-color: #EF4444;
                                    }

                                    .toast-content {
                                        display: flex;
                                        align-items: center;
                                        gap: 12px;
                                    }

                                    .toast-icon {
                                        font-size: 1.5rem;
                                    }

                                    .toast.success .toast-icon {
                                        color: #22C55E;
                                    }

                                    .toast.error .toast-icon {
                                        color: #EF4444;
                                    }

                                    @keyframes slideIn {
                                        from {
                                            transform: translateX(400px);
                                            opacity: 0;
                                        }

                                        to {
                                            transform: translateX(0);
                                            opacity: 1;
                                        }
                                    }

                                    .modal {
                                        display: none;
                                        position: fixed;
                                        inset: 0;
                                        align-items: center;
                                        justify-content: center;
                                        background: rgba(0, 0, 0, 0.6);
                                        z-index: 5000;
                                    }

                                    .modal.show {
                                        display: flex;
                                    }

                                    .modal-content {
                                        background: white;
                                        padding: 32px;
                                        border-radius: 16px;
                                        max-width: 500px;
                                        width: 90%;
                                        box-shadow: 0 16px 48px rgba(0, 0, 0, 0.3);
                                    }

                                    .modal-header {
                                        font-size: 1.6rem;
                                        color: var(--text);
                                        margin-bottom: 20px;
                                        font-weight: 700;
                                    }

                                    .modal-body {
                                        color: var(--muted-text);
                                        line-height: 1.6;
                                    }

                                    .modal-footer {
                                        display: flex;
                                        gap: 12px;
                                        justify-content: center;
                                        margin-top: 24px;
                                    }

                                    .modal-btn {
                                        padding: 10px 20px;
                                        border-radius: 10px;
                                        font-weight: 600;
                                        cursor: pointer;
                                        transition: all 0.3s ease;
                                        border: none;
                                    }

                                    .modal-btn-primary {
                                        background: var(--primary);
                                        color: white;
                                    }

                                    .modal-btn-secondary {
                                        background: var(--card-border);
                                        color: var(--text);
                                    }

                                    thead th {
                                        background: linear-gradient(135deg, #E3F2FD, #E8F4F8);
                                        color: #4A90E2;
                                        font-weight: 700;
                                        padding: 20px 15px;
                                        text-align: center;
                                        border-bottom: 2px solid #4A90E2;
                                        position: sticky;
                                        top: 0;
                                    }

                                    tbody tr {
                                        transition: all 0.3s ease;
                                    }

                                    tbody tr:nth-child(even) {
                                        background-color: #FAFAFA;
                                    }

                                    tbody tr:hover {
                                        background-color: #E3F2FD;
                                        transform: translateY(-2px);
                                        box-shadow: 0 5px 15px rgba(74, 144, 226, 0.15);
                                    }

                                    tbody td {
                                        padding: 18px 15px;
                                        text-align: center;
                                        border-bottom: 1px solid #E0E8F0;
                                        font-size: 1rem;
                                        color: #2C3E50;
                                    }

                                    .status-badge {
                                        padding: 8px 16px;
                                        border-radius: 20px;
                                        font-size: 0.9rem;
                                        font-weight: 500;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 6px;
                                    }

                                    .status-available {
                                        background: linear-gradient(45deg, #00ff88, #00cc6f);
                                        color: #000;
                                    }

                                    .status-occupied {
                                        background: linear-gradient(45deg, #ff4444, #cc0000);
                                        color: white;
                                    }

                                    .view-btn {
                                        background: linear-gradient(135deg, #4A90E2, #5CA9E9);
                                        color: white;
                                        border: none;
                                        padding: 10px 20px;
                                        border-radius: 20px;
                                        cursor: pointer;
                                        font-size: 0.95rem;
                                        font-weight: 600;
                                        transition: all 0.3s ease;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 8px;
                                        box-shadow: 0 3px 10px rgba(74, 144, 226, 0.3);
                                    }

                                    .view-btn:hover:not(:disabled) {
                                        background: linear-gradient(135deg, #5CA9E9, #4A90E2);
                                        transform: translateY(-2px);
                                        box-shadow: 0 5px 15px rgba(74, 144, 226, 0.4);
                                    }

                                    .view-btn:disabled {
                                        background: #9CA3AF !important;
                                        cursor: not-allowed !important;
                                        transform: none !important;
                                        box-shadow: none !important;
                                        opacity: 0.6;
                                    }


                                    .price {
                                        font-weight: 700;
                                        color: #4A90E2;
                                        font-size: 1.15rem;
                                    }

                                    .room-number {
                                        font-weight: 700;
                                        font-size: 1.15rem;
                                        color: #4A90E2;
                                    }

                                    .room-type {
                                        color: #6B7280;
                                        font-weight: 500;
                                    }


                                    .loading {
                                        display: none;
                                        position: fixed;
                                        top: 0;
                                        left: 0;
                                        width: 100%;
                                        height: 100%;
                                        background: rgba(0, 0, 0, 0.9);
                                        z-index: 2000;
                                        justify-content: center;
                                        align-items: center;
                                    }

                                    .spinner {
                                        width: 60px;
                                        height: 60px;
                                        border: 6px solid rgba(255, 140, 0, 0.2);
                                        border-top: 6px solid #ff8c00;
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


                                    .empty-state {
                                        text-align: center;
                                        padding: 60px 20px;
                                        color: #666;
                                    }

                                    .empty-state i {
                                        font-size: 4rem;
                                        margin-bottom: 20px;
                                        color: rgba(255, 140, 0, 0.3);
                                    }

                                    .empty-state h3 {
                                        font-size: 1.5rem;
                                        margin-bottom: 10px;
                                        color: #ff8c00;
                                    }

                                    .empty-state p {
                                        font-size: 1.1rem;
                                        color: #999;
                                    }

                                    .toast {
                                        position: fixed;
                                        top: 20px;
                                        right: 20px;
                                        background: linear-gradient(145deg, #2d2d2d, #1a1a1a);
                                        padding: 15px 20px;
                                        border-radius: 10px;
                                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
                                        border: 1px solid rgba(255, 140, 0, 0.5);
                                        z-index: 1001;
                                        display: none;
                                        animation: slideInRight 0.3s ease;
                                        color: #fff;
                                    }

                                    .toast.success {
                                        border-left: 4px solid #00ff88;
                                    }

                                    .toast.error {
                                        border-left: 4px solid #ff4444;
                                    }

                                    /* Modal Styles */
                                    .modal {
                                        display: none;
                                        position: fixed;
                                        z-index: 2000;
                                        left: 0;
                                        top: 0;
                                        width: 100%;
                                        height: 100%;
                                        background-color: rgba(0, 0, 0, 0.7);
                                        backdrop-filter: blur(5px);
                                    }

                                    .modal-content {
                                        background: linear-gradient(145deg, #FFFFFF, #F0F8FF);
                                        padding: 30px;
                                        border: 2px solid #4A90E2;
                                        border-radius: 15px;
                                        width: 90%;
                                        max-width: 500px;
                                        position: fixed;
                                        top: 50%;
                                        left: 50%;
                                        transform: translate(-50%, -50%);
                                        box-shadow: 0 10px 40px rgba(74, 144, 226, 0.3);
                                        text-align: center;
                                        animation: modalFadeIn 0.3s ease-out;
                                    }

                                    @keyframes modalFadeIn {
                                        from {
                                            opacity: 0;
                                            transform: translate(-50%, -50%) scale(0.9);
                                        }

                                        to {
                                            opacity: 1;
                                            transform: translate(-50%, -50%) scale(1);
                                        }
                                    }

                                    .modal-header {
                                        margin-bottom: 20px;
                                    }

                                    .modal-header i {
                                        font-size: 3rem;
                                        color: #EF4444;
                                        margin-bottom: 15px;
                                    }

                                    .modal-header h2 {
                                        color: #EF4444;
                                        font-size: 1.5rem;
                                        margin: 0;
                                    }

                                    .modal-body {
                                        color: #333;
                                        font-size: 1.1rem;
                                        line-height: 1.6;
                                        margin-bottom: 25px;
                                    }

                                    .modal-body h3 {
                                        color: #4A90E2;
                                        margin: 10px 0;
                                    }

                                    .modal-footer .btn {
                                        padding: 14px 40px;
                                        border: none;
                                        border-radius: 25px;
                                        font-size: 1.1rem;
                                        font-weight: 600;
                                        cursor: pointer;
                                        transition: all 0.3s ease;
                                        background: linear-gradient(135deg, #EF4444, #DC2626);
                                        color: white;
                                        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
                                        font-family: 'Sarabun', sans-serif;
                                    }

                                    .modal-footer .btn:hover {
                                        transform: translateY(-2px);
                                        box-shadow: 0 6px 20px rgba(239, 68, 68, 0.5);
                                        background: linear-gradient(135deg, #DC2626, #B91C1C);
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
                                        .container {
                                            padding: 10px;
                                        }

                                        .header {
                                            font-size: 2rem;
                                        }

                                        .top-bar {
                                            flex-direction: column;
                                            gap: 15px;
                                            text-align: center;
                                        }

                                        .nav {
                                            flex-direction: column;
                                            gap: 10px;
                                            align-items: center;
                                        }

                                        .nav a {
                                            width: 100%;
                                            max-width: 250px;
                                            justify-content: center;
                                        }

                                        .form-group {
                                            display: block;
                                            margin: 15px 0;
                                        }

                                        .form-group select {
                                            width: 100%;
                                            min-width: auto;
                                        }

                                        .search-btn {
                                            width: 100%;
                                            margin: 10px 0 0 0;
                                        }

                                        .rooms-grid {
                                            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                                        }

                                        table {
                                            font-size: 0.9rem;
                                        }

                                        tbody td {
                                            padding: 15px 8px;
                                        }

                                        .dropdown {
                                            position: static;
                                        }

                                        .dropdown-content {
                                            position: static;
                                            display: block;
                                            box-shadow: none;
                                            background: rgba(255, 140, 0, 0.1);
                                            border: 1px solid rgba(255, 140, 0, 0.2);
                                            margin-top: 10px;
                                        }

                                        .rental-alert {
                                            padding: 15px;
                                        }

                                        .rental-alert .alert-content {
                                            font-size: 1rem;
                                        }
                                    }

                                    @media (max-width: 480px) {
                                        .rooms-grid {
                                            grid-template-columns: 1fr;
                                            gap: 14px;
                                            padding: 12px;
                                        }
                                    }
                                </style>
                            </head>

                            <body>
                                <!-- Loading Animation -->
                                <div class="loading" id="loading">
                                    <div class="spinner"></div>
                                </div>

                                <!-- Modal Alert -->
                                <div id="alertModal" class="modal">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h2 style="color: #ff4444;">แจ้งเตือน</h2>
                                        </div>
                                        <div class="modal-body">
                                            <p id="modalMessage"></p>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn" onclick="closeModal()">
                                                <i class="fas fa-times"></i>
                                                ปิด
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Toast Notification -->
                                <div id="toast" class="toast">
                                    <div id="toast-message"></div>
                                </div>

                                <!-- Main Content -->
                                <div class="page-container">
                                    <!-- Header -->
                                    <div class="header">
                                        <h1>
                                            <i class="fas fa-building"></i>
                                            ThanaChok Place
                                        </h1>
                                        <div class="nav-menu">
                                            <a href="Homesucess" class="nav-link active">
                                                <i class="fas fa-home"></i> หน้าหลัก
                                            </a>
                                            <a href="YourRoom" class="nav-link">
                                                <i class="fas fa-door-open"></i> ห้องของฉัน
                                            </a>
                                            <a href="Listinvoice" class="nav-link">
                                                <i class="fas fa-file-invoice-dollar"></i> บิลค่าใช้จ่าย
                                            </a>
                                            <a href="Record" class="nav-link">
                                                <i class="fas fa-history"></i> ประวัติการจอง
                                                <c:if test="${approvedReservesCount > 0}">
                                                    <span
                                                        style="background:#22C55E; color:white; padding:3px 8px; border-radius:12px; font-size:0.75rem; font-weight:700; margin-left:6px;">
                                                        ${approvedReservesCount}
                                                    </span>
                                                </c:if>
                                            </a>
                                            <a href="Editprofile" class="nav-link">
                                                <i class="fas fa-user-edit"></i> แก้ไขโปรไฟล์
                                            </a>
                                        </div>
                                        <div class="user-section">
                                            <div class="user-info">
                                                <i class="fas fa-user-circle"></i>
                                                <span>${loginMember.firstName} ${loginMember.lastName}</span>
                                            </div>
                                            <form action="Logout" method="post" style="display:inline;">
                                                <button type="submit" class="logout-btn">
                                                    <i class="fas fa-sign-out-alt"></i>
                                                    ออกจากระบบ
                                                </button>
                                            </form>
                                        </div>

                                    </div>

                                    <!-- Search Section -->
                                    <div class="search-section">
                                        <form method="get" action="Homesucess" class="search-form">
                                            <h3>
                                                <i class="fas fa-search"></i>
                                                ค้นหาห้องพัก
                                            </h3>
                                            <div class="search-row">
                                                <div class="form-group">
                                                    <label for="floor">ชั้น:</label>
                                                    <select name="floor" id="floor">
                                                        <option value="">ทั้งหมด</option>
                                                        <c:forEach var="i" begin="1" end="5">
                                                            <option value="${i}" ${param.floor==i ? 'selected' : '' }>
                                                                ชั้น ${i}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="status">สถานะ:</label>
                                                    <select name="status" id="status">
                                                        <option value="">ทั้งหมด</option>
                                                        <option value="ว่าง" ${param.status=='ว่าง' ? 'selected' : '' }>
                                                            ว่าง</option>
                                                        <option value="ไม่ว่าง" ${param.status=='ไม่ว่าง' ? 'selected'
                                                            : '' }>ไม่ว่าง</option>
                                                    </select>
                                                </div>

                                                <button type="submit" class="search-btn">
                                                    <i class="fas fa-search"></i>
                                                    ค้นหา
                                                </button>
                                            </div>
                                        </form>
                                    </div>

                                    <!-- Rooms Container -->
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
                                                    <p>ลองเปลี่ยนเงื่อนไขการค้นหาหรือรีเฟรชหน้าใหม่</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Hidden fields for authentication -->
                                                <input type="hidden" id="isLoggedIn" value="${not empty loginMember}">

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
                                                                    <span class="detail-value">฿${room.roomPrice}</span>
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

                                                                <button class="view-btn detail-btn"
                                                                    style="margin-top:8px; background:linear-gradient(135deg, #4A90E2, #5CA9E9);"
                                                                    data-room-id="${room.roomID}"
                                                                    data-room-status="${room.roomStatus}"
                                                                    data-room-number="${room.roomNumber}"
                                                                    onclick="handleViewRoom(this)">
                                                                    <i class="fas fa-eye"></i>
                                                                    ดูรายละเอียด
                                                                </button>

                                                                <c:choose>
                                                                    <c:when test="${room.roomStatus == 'ว่าง'}">
                                                                        <!-- ห้องว่าง: จองได้ -->
                                                                        <button class="view-btn booking-btn"
                                                                            style="background:linear-gradient(135deg, #22C55E, #16A34A);"
                                                                            data-room-id="${room.roomID}"
                                                                            data-room-status="${room.roomStatus}"
                                                                            data-room-number="${room.roomNumber}"
                                                                            onclick="handleReserveRoom(this)">
                                                                            <i class="fas fa-calendar-check"></i>
                                                                            จองห้องพัก
                                                                        </button>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <!-- ห้องไม่ว่าง: มีคนจ่ายเงินแล้ว จองไม่ได้ -->
                                                                        <button class="view-btn booking-btn"
                                                                            style="background:linear-gradient(135deg, #EF4444, #DC2626); cursor: not-allowed;"
                                                                            data-room-id="${room.roomID}"
                                                                            data-room-status="${room.roomStatus}"
                                                                            data-room-number="${room.roomNumber}"
                                                                            disabled>
                                                                            <i class="fas fa-ban"></i>
                                                                            ห้องไม่ว่าง
                                                                        </button>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <script>
                                    // ข้อมูลจาก server (ส่งมาจาก JSP)
                                    const serverActiveRentalCount = ${ not empty activeRentalCount ?activeRentalCount: 0};
                                    const hasActiveRental = serverActiveRentalCount > 0;

                                    // ฟังก์ชันสำหรับจองห้องพัก
                                    function handleReserveRoom(button) {
                                        const roomID = button.getAttribute('data-room-id');
                                        const roomNumber = button.getAttribute('data-room-number');

                                        // ตรวจสอบการล็อกอิน
                                        const isLoggedIn = document.getElementById('isLoggedIn').value === 'true';
                                        if (!isLoggedIn) {
                                            showToast("กรุณาเข้าสู่ระบบก่อนทำการจองห้องพัก", "error");
                                            window.location.href = "Login";
                                            return;
                                        }

                                        // อนุญาตให้จองได้หลายห้อง - ไม่ตรวจสอบการจองอื่นๆ
                                        // Backend จะตรวจสอบว่าจองห้องเดียวกันซ้ำหรือไม่เท่านั้น
                                        showReservationModal(roomID, roomNumber);
                                    }

                                    // ฟังก์ชันแสดง modal ยืนยันการจองพร้อมเลือกวันที่เข้าพัก
                                    function showReservationModal(roomID, roomNumber) {
                                        const today = new Date();
                                        const minDate = new Date(today);
                                        minDate.setDate(today.getDate() + 5); // เพิ่ม 5 วัน

                                        const todayStr = today.toISOString().split('T')[0];
                                        const minDateStr = minDate.toISOString().split('T')[0];

                                        const modalContent = `
            <div style="text-align: center;">
                <i class="fas fa-calendar-check" style="font-size: 3rem; color: #22C55E; margin-bottom: 20px;"></i>
                <h3 style="color: #4A90E2; margin-bottom: 15px; font-size: 1.5rem;">ยืนยันการจองห้องพัก</h3>
                <div style="margin: 20px 0; padding: 20px; background: rgba(74, 144, 226, 0.1); border-radius: 12px; border: 2px solid #4A90E2;">
                    <p style="font-size: 0.9rem; color: #666; margin-bottom: 8px;">หมายเลขห้อง</p>
                    <p style="font-size: 2rem; font-weight: 700; color: #4A90E2; margin: 0;">` + roomNumber + `</p>
                </div>
                <form id="reserveForm" style="margin-top: 20px;">
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; color: #4A90E2; margin-bottom: 8px; font-weight: 600; font-size: 1rem;">
                            <i class="fas fa-calendar"></i> วันที่ต้องการเข้าพัก:
                        </label>
                        <input type="date" id="checkInDate" name="checkInDate" 
                               min="` + minDateStr + `" required
                               style="padding: 14px; border-radius: 12px; border: 2px solid #4A90E2; 
                                      background: #F0F7FF; color: #333; font-size: 1rem; width: 100%; max-width: 400px;
                                      font-family: 'Sarabun', sans-serif; font-weight: 500;">
                        <p style="font-size: 0.85rem; color: #EF4444; margin-top: 8px; margin-bottom: 0;">
                            <i class="fas fa-exclamation-circle"></i> ต้องจองล่วงหน้าอย่างน้อย 5 วัน (เลือกได้ตั้งแต่วันที่ ` + minDateStr + `)
                        </p>
                    </div>
                    <div style="margin-bottom: 15px;">
                        <label style="display: flex; align-items: center; gap: 10px; cursor: pointer; 
                                      padding: 12px; background: rgba(74, 144, 226, 0.05); border-radius: 8px; 
                                      border: 2px solid #4A90E2; transition: all 0.3s ease;">
                            <input type="checkbox" id="internetOption" name="internetOption" 
                                   style="width: 20px; height: 20px; cursor: pointer; accent-color: #4A90E2;">
                            <span style="font-weight: 600; color: #4A90E2; font-size: 1rem;">
                                <i class="fas fa-wifi"></i> ต้องการอินเทอร์เน็ต (+200 บาท/เดือน)
                            </span>
                        </label>
                    </div>
                    <input type="hidden" name="roomID" value="${roomID}">
                    <button type="submit" style="background: linear-gradient(135deg, #22C55E, #16A34A); 
                                                  color: white; border: none; padding: 14px 40px; 
                                                  border-radius: 25px; font-size: 1.1rem; font-weight: 600; 
                                                  cursor: pointer; margin-top: 15px; box-shadow: 0 4px 12px rgba(34, 197, 94, 0.3);
                                                  transition: all 0.3s ease; font-family: 'Sarabun', sans-serif;">
                        <i class="fas fa-check"></i> ยืนยันการจอง
                    </button>
                </form>
                <p style="margin-top: 20px; color: #666; font-size: 0.9rem;">
                    <i class="fas fa-info-circle"></i> หลังจากส่งคำขอ ผู้จัดการจะตรวจสอบและอนุมัติภายใน 24 ชั่วโมง
                </p>
            </div>
        `;

                                        document.getElementById('modalMessage').innerHTML = modalContent;
                                        document.getElementById('alertModal').style.display = 'block';

                                        // จัดการการส่งฟอร์ม
                                        document.getElementById('reserveForm').addEventListener('submit', function (e) {
                                            e.preventDefault();
                                            const checkInDate = document.getElementById('checkInDate').value;
                                            if (!checkInDate) {
                                                showToast("กรุณาเลือกวันที่เข้าพัก", "error");
                                                return;
                                            }

                                            // ตรวจสอบว่าวันที่เข้าพักอยู่ในอนาคตอย่างน้อย 5 วัน
                                            const selectedDate = new Date(checkInDate);
                                            const todayDate = new Date();
                                            todayDate.setHours(0, 0, 0, 0);
                                            selectedDate.setHours(0, 0, 0, 0);

                                            const diffTime = selectedDate - todayDate;
                                            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

                                            if (diffDays < 5) {
                                                showToast("กรุณาเลือกวันที่เข้าพักอย่างน้อย 5 วันจากวันนี้", "error");
                                                return;
                                            }

                                            // แสดง loading
                                            document.getElementById('loading').style.display = 'flex';
                                            closeModal();

                                            // สร้างฟอร์มและส่งข้อมูล
                                            const form = document.createElement('form');
                                            form.method = 'POST';
                                            form.action = 'MemberReserveRoom';

                                            const roomInput = document.createElement('input');
                                            roomInput.type = 'hidden';
                                            roomInput.name = 'roomID';
                                            roomInput.value = roomID;

                                            const dateInput = document.createElement('input');
                                            dateInput.type = 'hidden';
                                            dateInput.name = 'checkInDate';
                                            dateInput.value = checkInDate;

                                            // ส่งเวลาจองปัจจุบัน (milliseconds) จากฝั่ง client - รักษาเวลาท้องถิ่น
                                            const timestampInput = document.createElement('input');
                                            timestampInput.type = 'hidden';
                                            timestampInput.name = 'reserveTimestamp';
                                            timestampInput.value = new Date().toISOString(); // ส่งเป็น ISO UTC

                                            // ส่งค่าอินเทอร์เน็ต
                                            const internetInput = document.createElement('input');
                                            internetInput.type = 'hidden';
                                            internetInput.name = 'internetOption';
                                            internetInput.value = document.getElementById('internetOption').checked;

                                            form.appendChild(roomInput);
                                            form.appendChild(dateInput);
                                            form.appendChild(timestampInput);
                                            form.appendChild(internetInput);
                                            document.body.appendChild(form);
                                            form.submit();
                                        });
                                    }

                                    // ฟังก์ชันแสดง Toast
                                    function showToast(message, type = 'success') {
                                        const toast = document.getElementById('toast');
                                        const toastMessage = document.getElementById('toast-message');

                                        toastMessage.textContent = message;
                                        toast.className = `toast ${type}`;
                                        toast.style.display = 'block';

                                        setTimeout(() => {
                                            toast.style.display = 'none';
                                        }, 5000);
                                    }

                                    // Modal functions
                                    function showModal(message) {
                                        document.getElementById('modalMessage').innerHTML = message;
                                        document.getElementById('alertModal').style.display = 'flex';
                                        document.body.style.overflow = 'hidden';
                                    }

                                    function closeModal() {
                                        document.getElementById('alertModal').style.display = 'none';
                                        document.body.style.overflow = 'auto';
                                    }

                                    // ฟังก์ชันจัดการคลิกปุ่มดูห้อง
                                    function handleViewRoom(button) {
                                        const roomID = button.getAttribute('data-room-id');

                                        if (!roomID) {
                                            showToast('ไม่พบข้อมูลห้อง', 'error');
                                            return;
                                        }

                                        // อนุญาตให้ดูรายละเอียดห้องได้เสมอ
                                        // แสดง loading
                                        const loadingElement = document.getElementById('loading');
                                        if (loadingElement) {
                                            loadingElement.style.display = 'flex';
                                        }

                                        // Redirect ไปหน้ารายละเอียดห้อง
                                        window.location.href = 'roomDetail?id=' + roomID;
                                    }

                                    // เมื่อโหลดหน้า
                                    window.addEventListener('load', function () {
        <c:if test="${not empty message}">
            showToast("${message}", "success");
        </c:if>

        <c:if test="${not empty errorMessage}">
            showToast("${errorMessage}", "error");
        </c:if>
        
        // Check for reservation success/error
        <c:if test="${param.reserveSuccess eq 'true'}">
            showToast("✅ จองห้องพักสำเร็จ! รอการอนุมัติจากเจ้าของหอพัก", "success");
            // Remove parameter from URL
            setTimeout(() => {
                const url = new URL(window.location);
                url.searchParams.delete('reserveSuccess');
                window.history.replaceState({}, '', url);
            }, 100);
        </c:if>
        
        <c:if test="${param.reserveError eq 'true'}">
            showToast("❌ จองห้องพักไม่สำเร็จ กรุณาลองใหม่อีกครั้ง", "error");
            // Remove parameter from URL
            setTimeout(() => {
                const url = new URL(window.location);
                url.searchParams.delete('reserveError');
                window.history.replaceState({}, '', url);
            }, 100);
        </c:if>
        
        <c:if test="${param.reserveError eq 'roomNotAvailable'}">
            showToast("❌ ห้องนี้ไม่ว่างแล้ว กรุณาเลือกห้องอื่น", "error");
            // Remove parameter from URL
            setTimeout(() => {
                const url = new URL(window.location);
                url.searchParams.delete('reserveError');
                window.history.replaceState({}, '', url);
                // Reload to refresh room status
                setTimeout(() => location.reload(), 2000);
            }, 100);
        </c:if>
        
        <c:if test="${param.reserveError eq 'hasActiveReserve'}">
            showToast("❌ คุณมีการจองห้องอยู่แล้ว ไม่สามารถจองห้องอื่นได้อีก", "error");
            // Remove parameter from URL
            setTimeout(() => {
                const url = new URL(window.location);
                url.searchParams.delete('reserveError');
                window.history.replaceState({}, '', url);
            }, 100);
        </c:if>
        
        <c:if test="${param.reserveError eq 'alreadyReservedThisRoom'}">
            showToast("❌ คุณได้จองห้องนี้ไว้แล้ว ไม่สามารถจองซ้ำได้", "error");
            // Remove parameter from URL
            setTimeout(() => {
                const url = new URL(window.location);
                url.searchParams.delete('reserveError');
                window.history.replaceState({}, '', url);
            }, 100);
        </c:if>

                                        document.body.style.opacity = '0';
                                        document.body.style.transition = 'opacity 0.5s ease-in-out';

                                        setTimeout(function () {
                                            document.body.style.opacity = '1';
                                            document.getElementById('loading').style.display = 'none';
                                        }, 100);
                                    });


                                </script>
                            </body>

                            </html>