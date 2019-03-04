<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="WebApp.TrangChu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trang chủ - Quản lý thiết bị viễn thông VNPT</title>
    <!--style-core-->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link href="css/home.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="header-top">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-8">

                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-4">
                        <div id="loginInfo">
                            <ul>
                                <li>Xin chào: <a href="/">Tuyển Giảng</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div><!--header-top-->
        <header id="header">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-2">
                       <div id="logo">
                            <a href="/"><h2>VNPT TB</h2></a>
                       </div>
                    </div>
                    <div class="col-md-8" id="header-center">
                        <div class="header-menu">
                            <ul>
                                <li><a href="/"><i class="fa fa-home"></i> Trang chủ</a></li>
                                <li><a href="/">Quản lý thiết bị</a></li>
                                <li><a href="/">Quản lý danh mục <i class="fa fa-angle-down"></i></a>
                                     <ul class="sub-menu">
                                        <li><a href="#">Danh mục đơn vị</a></li>
                                        <li><a href="#">Danh mục nhà trạm</a></li>
                                        <li><a href="#">Danh mục loại thiết bị</a></li>
                                    </ul>
                                </li>
                                <li><a href="/">Quản lý người dùng <i class="fa fa-angle-down"></i></a>
                                     <ul class="sub-menu">
                                        <li><a href="#">Thêm tài khoản mới</a></li>
                                        <li><a href="#">Danh Sách tài khoản</a></li>
                                    </ul>
                                </li>                                
                            </ul>
                        </div>
                    </div>
                    
                </div>
            </div>
        </header><!--header-->
        <main id="main">
            <div class="container">
                <div class="col-xs-12 col-sm-12 col-md-4 sidebar-container">

                </div><!--sidebar-container-->
                <div class="col-xs-12 col-sm-12 col-md-8 main-container">

                </div><!--main-container-->
            </div>
        </main><!--main-->
        <!--script-core-->
        <script src="css/jquery.js"></script>
        <script src="css/main.js"></script>
        <footer id="footer">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-md-6 col-md-offset-3">
                        <div class="footer-top">
                            Copyright &copy; 2019 Thực Tập. All rights reserved
                        </div>
                    </div>
                </div>
            </div>
        </footer><!--footer-->
    </form>
</body>
</html>
