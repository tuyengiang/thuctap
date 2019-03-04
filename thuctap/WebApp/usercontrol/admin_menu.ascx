<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_menu.ascx.cs" Inherits="MyNews.admin_menu" %>

<link href="css/font-awesome.min.css" rel="stylesheet" />

<nav class="navbar navbar-inverse" role="banner" style="z-index: 999; border-bottom: 2px solid  #005395">
    <div class="container" style="height: 30px">
        <div class="row">


            <div class="navbar-header col-md-1  pright-0" style="padding-top: 5px;">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

                <a class="navbar-brand"  title="Website" href="/admin_main.aspx">
                   <%-- <img src="/images/logos.png" alt="logo" height="65px">--%>
                </a>
            </div>

            <div class="collapse navbar-collapse navbar-left col-md-12" style="background-color: #fff;">
                <div class="row">
                    <div class="col-md-12">
                        <ul class="nav navbar-nav">
                            <li class="mobile"><a href="/admin_banhangs.aspx">Trang chủ </a></li>
                            <li class="mobile"><a href="/admin_banhang1.aspx">Tra cứu </a></li>
                            <%--<li class="mobile"><a href="/tinnhan/0-0">Tin nhắn </a></li>--%>
                            <asp:Repeater ID="rptCha" runat="server" OnItemDataBound="rptCha_ItemDataBound">
                                <ItemTemplate>
                                    <li class="dropdown mobile">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><%#Eval("name") %></a>
                                        </a>
                              <ul class="dropdown-menu">
                                  <asp:Repeater ID="rpt" runat="server">
                                      <ItemTemplate>
                                          <li>
                                              <a href="<%#Eval("link") %>"><%#Eval("name") %> </a>
                                          </li>
                                      </ItemTemplate>
                                  </asp:Repeater>
                              </ul>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                            <%-- <li><a style="color: #fff" href="/dangnhap">Thoát </a></li>--%>
                        </ul>


                    </div>

                </div>

            </div>
        </div>
    </div>

</nav>

<%--<div id="myModalChange" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">

        <div class="modal-content panel-primary">
            <div class="modal-header" style="background: #005395">
                <button type="button" style="color: #fff" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" style="color: #fff">Đổi mật khẩu</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3">
                        Mật khẩu cũ
                    </div>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtOldPass" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="row" style="padding-top: 5px">
                    <div class="col-md-3">
                        Mật khẩu mới
                    </div>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtNewPass" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="row" style="padding-top: 5px">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-9">
                        <asp:LinkButton ID="btnChange" OnClick="btnChange_Click" CssClass="btn btn-success" runat="server"> <i class="fa fa-save"></i> Cập nhật</asp:LinkButton>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>

<div id="myModalUpdate" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">

        <div class="modal-content panel-primary">
            <div class="modal-header" style="background: #005395">
                <button type="button" style="color: #fff" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" style="color: #fff">Cập nhật thông tin</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3 col-xs-3">
                        Họ Tên
                    </div>
                    <div class="col-md-9 col-xs-9">
                        <asp:TextBox ID="txtName" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                </div>
                <div class="row" style="padding-top: 5px">
                    <div class="col-md-3 col-xs-3">
                        Email
                    </div>
                    <div class="col-md-9 col-xs-9">
                        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                </div>
                <div class="row" style="padding-top: 5px">
                    <div class="col-md-3 col-xs-3">
                        Điện thoại
                    </div>
                    <div class="col-md-9 col-xs-9">
                        <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                </div>
                <div class="row" style="padding-top: 5px">
                    <div class="col-md-3 col-xs-3">
                        Địa chỉ
                    </div>
                    <div class="col-md-9 col-xs-9">
                        <asp:TextBox ID="txtAddress" TextMode="MultiLine" Height="80px" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                </div>

                <div class="row" style="padding-top: 5px">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-9">
                        <asp:LinkButton ID="btnUpdate" OnClick="btnUpdate_Click" CssClass="btn btn-success" runat="server"> <i class="fa fa-save"></i> Cập nhật</asp:LinkButton>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>--%>
