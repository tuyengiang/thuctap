<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/SiteAdmin.Master" CodeBehind="admin_menu.aspx.cs" Inherits="WebApp.Admin.admin_menu" %>
<asp:Content ID="Account_1" ContentPlaceHolderID="headerTitle" runat="server">
    <title>VNPT - Danh sách menu</title>
</asp:Content>
<asp:Content ID="Account_2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/Admin/admin_menu.aspx">Danh sách menu</a>
                </div>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus-circle"></i> Thêm mới menu</button>
        </div><!--breadcrum-->
        <div class="row" id="form">
            <div class="col-xs-12 col-sm-12 col-md-4">
                <div class="form-group">
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-3">
                <div class="form-group">
                     <asp:DropDownList ID="searchSelect" runat="server" CssClass="form-control">
                        <asp:ListItem Text="--- Tìm kiếm theo ---" Value="NULL"></asp:ListItem>
                        <asp:ListItem Text="Tên menu" Value="tentk"></asp:ListItem>
                        <asp:ListItem Text="Cấp menu" Value="tenht"></asp:ListItem>
                     </asp:DropDownList>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-3">
                <div class="form-group">
                   <asp:TextBox ID="inputSearch" runat="server" CssClass="form-control" placeholder="Nhập từ khóa tìm kiếm"></asp:TextBox>
                </div>
             </div>
            <div class="col-xs-12 col-sm-12 col-md-2">
                <span><asp:LinkButton ID="btnSearch" ValidationGroup="Search" runat="server" CssClass="btn btn-primary" ><i class="fa fa-search"></i></asp:LinkButton></span>
                <span><asp:LinkButton ID="btn_refresh" ValidationGroup="Refresh" runat="server" CssClass="btn btn-success" ><i class="fa fa-refresh"></i> Refresh</asp:LinkButton></span>
            </div>
      </div>
        <div class="row">
            <div class="table-responsive">
                  <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" OnRowCommand="example_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="name" HeaderText="Tên menu" SortExpression="ma_donvi" />
                            <asp:BoundField DataField="link" HeaderText="Đường dẫn" SortExpression="ten_donvi" />
                            <asp:BoundField DataField="id_Menu" HeaderText="Cấp Menu" SortExpression="dia_chi" />
                            <asp:TemplateField HeaderText="Chức năng">
                                <ItemTemplate>
                                     <asp:LinkButton ID="btnReset" ValidationGroup="reset" runat="server" CommandArgument='<%#Eval("ID") %>' CssClass="btn btn-primary"  data-target="#myMoEdit" CommandName="edit"><i class="fa fa-edit"></i></asp:LinkButton>
                                     <asp:LinkButton ID="btnDelete" ValidationGroup="delete" runat="server" CommandArgument='<%#Eval("ID") %>' CssClass="btn btn-danger"  data-target="#myMoDelete"  CommandName="xoa"><i class="fa fa-trash" aria-hidden="true"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                         </Columns>
                   </asp:GridView>
              </div>
            </div>
         <div class="row">
                <!-- Modal add -->
                  <div class="modal fade login" id="myModal" role="dialog">
                    <div class="modal-dialog modal_login">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Thêm tài khoản mới</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                   <td>Menu Cha <span>*</span></td>
                                   <td>
                                       <asp:DropDownList ID="MenuCha" runat="server" CssClass="form-control">
                                           <asp:ListItem Text="Không có" Value="Null"></asp:ListItem>
                                       </asp:DropDownList>
                                   </td>
                                </tr>
                                <tr>
                                   <td>Tên menu <span>*</span></td>
                                   <td>
                                       <asp:TextBox ID="txt_name" runat="server" CssClass="form-control" placeholder="Nhập tên menu"></asp:TextBox>
                                        <asp:RequiredFieldValidator  ValidationGroup="Popup" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Tên menu không được bỏ trống !!!" ControlToValidate="txt_name" Display="Dynamic"></asp:RequiredFieldValidator>
                                   </td>
                                </tr>
                                <tr>
                                   <td>Đường dẫn <span>*</span></td>
                                   <td>
                                       <asp:TextBox ID="txt_url" runat="server" CssClass="form-control" placeholder="Nhập đường dẫn menu"></asp:TextBox>
                                        <asp:RequiredFieldValidator  ValidationGroup="Popup" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Đường dẫn không được bỏ trống !!!" ControlToValidate="txt_url" Display="Dynamic"></asp:RequiredFieldValidator>
                                   </td>
                                </tr>
                                <tr>
                                   <td>Hoạt Ảnh</td>
                                   <td>
                                       <asp:DropDownList ID="hoatAnh" runat="server" CssClass="form-control">
                                             <asp:ListItem Text="Không có" Value="Null"></asp:ListItem>
                                             <asp:ListItem Text="Dropdown" Value="collapse"></asp:ListItem>
                                       </asp:DropDownList>
                                   </td>
                                </tr>
                                <tr>
                                   <td>Icon Menu <span>*</span></td>
                                   <td><asp:TextBox ID="txt_icon" runat="server" CssClass="form-control" placeholder="fa fa-user (Font Awesome)"></asp:TextBox></td>
                                </tr>
                                <tr>
                                   <td>Icon Submenu</td>
                                   <td><asp:TextBox  ID="txt_submenu" runat="server" CssClass="form-control" placeholder="fa fa-user (Font Awesome)"></asp:TextBox></td>
                                </tr>
                                 <tr>
                                   <td>Tên hoạt ảnh</td>
                                   <td><asp:TextBox ID="txt_nameha" runat="server" CssClass="form-control" placeholder="Nhập đường dẫn menu"></asp:TextBox></td>
                                 </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnAdd" runat="server" OnClick="btnAdd_Click" ValidationGroup="Popup" CssClass="btn btn-success"><i class="fa fa-plus-circle"></i> Thêm tài khoản</asp:LinkButton>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-add-->

                <!--modal edit -->
              <div class="modal fade" id="myMoEdit" role="dialog">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Reset mật khẩu</h4>
                        </div>
                        <div class="modal-body">
                            <asp:TextBox ID="txt_resset" runat="server" Visible="False"></asp:TextBox>
                            <table class="table">
                                <tr>
                                    <td>Mật khẩu mới</td>
                                    <td>
                                        <asp:TextBox ID="txt_passnew" Text="12345678" runat="server" CssClass="form-control text-input" TextMode="Password" placeholder="Nhập mật khẩu mới"></asp:TextBox>
                                        <asp:RequiredFieldValidator EnableClientScript="true" ValidationGroup="Popup1"  ID="RequiredFieldValidator5" runat="server" ErrorMessage="Tên hiển thị không được bỏ trống !!!" ControlToValidate="txt_passnew" Display="Dynamic"></asp:RequiredFieldValidator>                                        
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnResset" runat="server" CssClass="btn btn-success" ValidationGroup="Popup1" ><i class="fa fa-refresh"></i> Resset mật khẩu</asp:LinkButton>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-delete-->
              <div class="modal fade" id="myMoDelete" role="dialog">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Thông báo</h4>
                        </div>
                        <div class="modal-body">
                           <asp:TextBox ID="txt_xoa" runat="server" Visible="False"></asp:TextBox>
                           <h3>Ban có muốn xóa tài khoản <asp:Label ID="txt_ten2" runat="server" Text="Label"></asp:Label> này không ?</h3>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnDelete" OnClick="btnDelete_Click" ValidationGroup="Popup2" runat="server" CssClass="btn btn-success" ><i class="fa fa-trash"></i> Xóa</asp:LinkButton>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-delete-->
         </div><!--modal-->
    </form>
</asp:Content>
