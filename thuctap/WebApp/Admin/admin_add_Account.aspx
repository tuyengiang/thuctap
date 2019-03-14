<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_add_Account.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.Admin.admin_add_Account" %>
<asp:Content ID="Account_1" ContentPlaceHolderID="headerTitle" runat="server">
    <title>VNPT - Danh sách tài khoản</title>
</asp:Content>
<asp:Content ID="Account_2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/Admin/admin_add_Account.aspx">Danh sách tài khoản</a>
                </div>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus-circle"></i> Thêm mới tài khoản</button>
                <a href="/Admin/admin_ds_remove_account.aspx" class="btn btn-warning" style="margin-left:10px !important"><i class="fa fa-trash"></i> Khôi phục tài khoản</a>
                <button type="submit" class="btn btn-default" style="margin-left:10px;" onclick="return confirm('Bạn có muốn load lại trang không?');"><i class="fa fa-refresh"></i> Tải lại trang</button>
          </div><!--breadcrum-->
         
        <div class="row">
            <div class="table-responsive">
                  <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" OnRowCommand="example_RowCommand" OnRowDataBound="example_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="name_user" HeaderText="Tên tài khoản" SortExpression="ma_donvi" />
                            <asp:BoundField DataField="tenhienthi" HeaderText="Tên hiển thị" SortExpression="ten_donvi" />
                            <asp:BoundField DataField="sdt" HeaderText="Số điện thoại" SortExpression="dia_chi" />
                            <asp:BoundField DataField="ten_donvi" HeaderText="Đơn vị" SortExpression="dia_chi" />
                            <asp:BoundField DataField="gioitinhA" HeaderText="Giới tính" SortExpression="dia_chi" />
                            <asp:BoundField DataField="name_super" HeaderText="Quyền hạn" SortExpression="dia_chi" />
                            <asp:TemplateField HeaderText="Chức năng">
                                <ItemTemplate>
                                     <asp:LinkButton ID="btnReset" runat="server" CommandArgument='<%#Eval("name_user") %>' CssClass="btn btn-secondary"  data-target="#myMoDelete" CommandName="resset" title="Cập nhật mật khẩu"><i class="fa fa-key"></i></asp:LinkButton>
                                     <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%#Eval("name_user") %>' CssClass="btn btn-danger"  data-target="#myMoDelete" title="Xóa tài khoản" CommandName="xoa"><i class="fa fa-trash" aria-hidden="true"></i></asp:LinkButton>
                                     <asp:LinkButton ID="btnKhoa" runat="server" CssClass="btn btn-warning"   CommandArgument='<%#Eval("name_user") %>' data-target="#myMoKhoa" title="Khóa cài khoản" CommandName="khoa"><i class="fa fa-lock"></i></asp:LinkButton>
                                     <asp:LinkButton ID="btn_Setup" runat="server" CommandArgument='<%#Eval("name_user") %>' CssClass="btn btn-primary"  data-target="#myMoSetting" CommandName="setting" title="Cài đặt tài khoản"><i class="fa fa-cog"></i></asp:LinkButton>
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
                                    <td>Tên tài khoản <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_username" runat="server" CssClass="form-control text-input" placeholder="Nhập tên tài khoản"></asp:TextBox>
                                    </td>
                                    <td style="padding-left:10px !important;">Tên hiển thị <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_name" runat="server" CssClass="form-control" placeholder="Nhập tên hiển thị"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Mật khẩu<span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_password" runat="server" CssClass="form-control text-input" placeholder="Nhập mật khẩu" TextMode="Password"></asp:TextBox>
                                    </td>
                                    <td style="padding-left:10px !important;">Ngày sinh<span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_ngaysinh" runat="server" CssClass="form-control text-input" TextMode="Date"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Số điện thoại<span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_sdt" runat="server" CssClass="form-control text-input" placeholder="Nhập số điện thoại" TextMode="Number"></asp:TextBox>
                                    </td>
                                    <td style="padding-left:10px !important;">Đơn vị <span>*</span></td>
                                    <td>
                                       <asp:DropDownList ID="id_donvi" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Giới tính<span>*</span></td>
                                    <td>
                                         <asp:DropDownList ID="gioi_tinh" runat="server" CssClass="form-control">
                                             <asp:ListItem Text="Nam" Value="true"></asp:ListItem>
                                             <asp:ListItem Text="Nữ" Value="false"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="padding-left:10px !important;">Phân quyền<span>*</span></td>
                                    <td>
                                       <asp:DropDownList ID="id_supper" runat="server" CssClass="form-control"></asp:DropDownList>                                        
                                    </td>
                                </tr>
                                 <tr>
                                    <td>Ảnh đại diện<span>*</span></td>
                                    <td>
                                         <asp:FileUpload ID="FileUpload1" runat="server" Width="220px" onchange="loadFile(event)" CssClass="form-control"/>                                   
                                    </td>
                                    <td style="padding-left:10px !important;"></td>
                                    <td>
                                         <img id="output"/>           
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-success" OnClick="btnAdd_Click"><i class="fa fa-plus-circle"></i> Thêm tài khoản</asp:LinkButton>
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
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnResset" runat="server" CssClass="btn btn-success" OnClick="btnResset_Click"><i class="fa fa-refresh"></i> Resset mật khẩu</asp:LinkButton>
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
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-success" OnClick="btnDelete_Click"><i class="fa fa-trash"></i> Xóa</asp:LinkButton>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-delete-->
            
            <div class="modal fade" id="myMoKhoa" role="dialog">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title">Thông báo</h4>
                            </div>
                            <div class="modal-body">
                                <asp:TextBox ID="txt_khoa" runat="server" Visible="False"></asp:TextBox>
                               <h3>Bạn có muốn khóa tài khoản <asp:Label ID="txt_ten" runat="server" Text="Label"></asp:Label> không ?</h3>
                            </div>
                            <div class="modal-footer">
                                <asp:LinkButton ID="btnKkhoaTK" runat="server" CssClass="btn btn-success" OnClick="btnKkhoaTK_Click"><i class="fa fa-lock"></i> Khóa tài khoản</asp:LinkButton>
                                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                            </div>
                          </div>
      
                        </div>
                    </div><!--modal-khóa-->
                 <div class="modal fade" id="myMoSetting" role="dialog">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title">Cài đặt tài khoản</h4>
                            </div>
                            <div class="modal-body">
                                <table class="table">
                                    <tr>
                                        <td>Tên tài khoản:</td>
                                        <td><asp:Label ID="title_setting" runat="server" Text="Label"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>Tình trạng tài khoản: </td>
                                        <td><asp:Label ID="title_khoa" runat="server" Text="Label"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>Mở khỏa tài khoản: </td>
                                        <td>
                                            <asp:DropDownList ID="mo_khoa" runat="server" CssClass="form-control">
                                                 <asp:ListItem Text="Mở khóa tải khoản" Value="false"></asp:ListItem>
                                                 <asp:ListItem Text="Khóa vĩnh viễn" Value="true"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                 
                            </div>
                            <div class="modal-footer">
                                <asp:LinkButton ID="btn_setting" runat="server" CssClass="btn btn-success" OnClick="btn_setting_Click"><i class="fa fa-save"></i> Save Setting</asp:LinkButton>
                                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                            </div>
                          </div>
      
                        </div>
                    </div><!--modal-setting-->
         </div><!--modal-->
    </form>
</asp:Content>
