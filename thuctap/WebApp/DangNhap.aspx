﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="MyNews.Admin.DangNhap" %>

<%@ Register Assembly="MSCaptcha" Namespace="MSCaptcha" TagPrefix="cc2" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng nhập</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body class="ThucTap-body">
    <form id="form1" runat="server">
        <section id="Dang-Nhap">
        <div class="row" style="margin-top: 50px; padding: 15px; background: none">
            <div class="col-md-4 col-lg-4">
                &nbsp;
            </div>
            <div class="col-md-4 col-lg-4">

                <div class="panel panel-primary" style="border:1px solid #009900">
                    <div class="panel-heading" style="text-align: center; font-size:16px; background: #009900">
                     
                        <p><b>ĐĂNG NHẬP HỆ THỐNG</b></p>
                    </div>
                    <div class="panel-body">
                        <div class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 col-sm-4 col-lg-4" style="text-align: left">
                                Tên đăng nhập
                            </div>
                            <div class="col-md-8 col-sm-8 col-lg-8">
                                <asp:TextBox ID="txtuser" CssClass="form-control" runat="server" placeholder="Tên đăng nhập"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 col-sm-4 col-lg-4" style="text-align: left">
                                Mật khẩu
                            </div>
                            <div class="col-md-8 col-sm-8 col-lg-8">
                                <asp:TextBox ID="txtpass" CssClass="form-control" runat="server" TextMode="Password" placeholder="Mật khẩu"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom: 5px">
                            <div class="col-md-4 col-sm-4 col-lg-4" style="text-align: left">
                               
                       
                            </div>
                            <div class="col-md-8 col-sm-8 col-lg-8">

                                <asp:Button ID="btndangnhap" runat="server" OnClick="btndangnhap_Click" Text="Đăng nhập" CssClass="btn btn-success" />
                                
                       
                            </div>
                        </div>
                        <div class="row" style="padding-bottom: 5px">
                             <div class="col-md-3" style="text-align: left">
                                 </div>
                            <div class="col-md-9" style="text-align: left">
                                <asp:Label ID="lblThongBao" runat="server" ForeColor="Red" Text=""></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-lg-4">
                &nbsp;
            </div>
        </div>
            </section>
    </form>
</body>
</html>
