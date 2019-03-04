<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="WebApp.TrangChu" %>
<%@ Register Src="~/usercontrol/header.ascx" TagPrefix="uc4" TagName="header" %>
<%@ Register Src="~/usercontrol/sidebar.ascx" TagPrefix="uc5" TagName="sidebar" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trang chủ - Quản lý thiết bị viễn thông VNPT</title>
    <!--style-core-->
    <meta name="Viewport" content="width=device-width,initial-scale=1" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link href="css/home.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/Css/telerik/myControl.css" />
    <link rel="stylesheet" href="/Css/telerik/ComboBox.Default.css" />
    <link rel="stylesheet" href="/Css/telerik/DatePicker.Default.css" />
    <link rel="stylesheet" href="/Css/telerik/Grid.Default.css" />
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <uc4:header ID="header" runat="server" />
        <main id="main">
            <div class="container">
                <uc5:sidebar ID="sidebar" runat="server" />
                <div class="col-xs-12 col-sm-12 col-md-9 main-container">
                    <div class="breadcrumb">
                        <span>
                            <a href="/"><i class="fa fa-home"></i> Trang Chủ</a>
                            <i class="fa fa-angle-double-right"></i>
                            <a href="/">Dashbroad</a>
                        </span>
                    </div>
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
