<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_ds_don_vi.aspx.cs" Inherits="WebApp.admin_ds_don_vi" %>
<%@ Register Src="~/usercontrol/header.ascx" TagPrefix="uc4" TagName="header" %>
<%@ Register Src="~/usercontrol/sidebar.ascx" TagPrefix="uc5" TagName="sidebar" %>
<!DOCTPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Danh sách đơn vị</title>
    <meta name="Viewport" content="width=device-width,initial-scale=1" />

    <!--style-core-->
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
                            <a href="/admin_ds_don_vi.aspx">Danh sách đơn vị</a>
                        
                        </span>
                    </div>
                    <div id="form">
                         <div class="row">
                        <div class="col-xs-12 col-md-10">
                            <div class="Form-class">
                                <div class="form-group">
                                    <asp:Label ID="Label1" runat="server" Text="Mã đơn vị"></asp:Label>
                                    <asp:TextBox ID="txt_madv" runat="server" CssClass="form-control" placeholder="Mã đơn vị"></asp:TextBox>                                    
                                   
                                </div>
                                 <div class="form-group">
                                     <asp:Label ID="Label2" runat="server" Text="Tên đơn vị"></asp:Label>
                                     <asp:TextBox ID="txt_tendv" runat="server" CssClass="form-control" placeholder="Tên đơn vị"></asp:TextBox>

                                </div>
                                 <div class="form-group" >
                                     <asp:Label ID="Label3" runat="server" Text="Địa chỉ"></asp:Label>
                                     <asp:TextBox ID="txt_diachi" runat="server" CssClass="form-control" placeholder="Địa chỉ đơn vị"></asp:TextBox>

                                </div>
                                <div class="form-group">
                                    <asp:Label ID="Label4" runat="server" Text="Mô tả về đơn vị"></asp:Label>
                                     <asp:TextBox ID="txt_mota" runat="server" CssClass="form-control" placeholder="Mô tả đơn vị"></asp:TextBox>

                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-2">
                            <div class="form-group"></div>
                            <div class="form-group">

                                <asp:Button ID="btn_add" runat="server" Text="Thêm" CssClass="btn btn-primary btn-custom" OnClick="btn_add_Click3" />
                            </div>
                            <div class="form-group">
                                <asp:Button ID="btn_edit" runat="server" Text="Sửa" CssClass="btn btn-success btn-custom"  />
                            </div>
                            <div class="form-group">
                                <asp:Button ID="btn_delete" runat="server" Text="Xóa" CssClass="btn btn-danger btn-custom" />
                            </div>
                       </div>
                    </div>
                    </div>
                    <div class="listview">
                        <div class="row">
                               <div class="col-xs-12 col-md-12">
                                   <asp:Label ID="Label5" runat="server" Text="Danh sách đơn vị"></asp:Label>
                                   <asp:GridView ID="ds" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"  AutoGenerateSelectButton="True">
                                       <Columns>
                                           <asp:BoundField DataField="id_donvi" HeaderText="STT" SortExpression="id" />
                                           <asp:BoundField DataField="ma_donvi" HeaderText="Mã đơn vị" SortExpression="madv" />
                                           <asp:BoundField DataField="ten_donvi" HeaderText="Tên đơn vị" SortExpression="ten_donvi" />
                                           <asp:BoundField DataField="dia_chi" HeaderText="Địa chỉ" SortExpression="dia_chi" />
                                           <asp:BoundField DataField="mo_ta" HeaderText="Mô tả" SortExpression="mo_ta" />
                                       </Columns>
                                   </asp:GridView>
                                   
                               </div>
                        </div>
                    </div>
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
