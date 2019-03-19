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
        </div><!--breadcrum-->
       <div class="row" id="form">
            <div class="col-xs-12 col-sm-12 col-md-4">
                <div class="form-group">
                     <asp:DropDownList ID="searchDV" runat="server" CssClass="form-control" OnSelectedIndexChanged="searchDV_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-3">
                <div class="form-group">
                     <asp:DropDownList ID="searchSelect" runat="server" CssClass="form-control">
                        <asp:ListItem Text="--- Tìm kiếm theo ---" Value="NULL"></asp:ListItem>
                        <asp:ListItem Text="Tên tài khoản" Value="tentk"></asp:ListItem>
                        <asp:ListItem Text="Tên hiển thị" Value="tenht"></asp:ListItem>
                     </asp:DropDownList>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-3">
                <div class="form-group">
                   <asp:TextBox ID="inputSearch" runat="server" CssClass="form-control" placeholder="Nhập từ khóa tìm kiếm"></asp:TextBox>
                </div>
             </div>
            <div class="col-xs-12 col-sm-12 col-md-2">
                <span><asp:LinkButton ID="btnSearch" ValidationGroup="Search" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click"><i class="fa fa-search"></i></asp:LinkButton></span>
                <span><asp:LinkButton ID="btn_refresh" ValidationGroup="Refresh" runat="server" CssClass="btn btn-success" OnClick="btn_refresh_Click"><i class="fa fa-refresh"></i> Refresh</asp:LinkButton></span>
            </div>
      </div>
        <div class="row">
            <div class="table-responsive">
                  <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" OnRowCommand="example_RowCommand" OnRowDataBound="example_RowDataBound" AllowPaging="True" PageSize="10" OnPageIndexChanging="example_PageIndexChanging" OnRowCreated="example_RowCreated">
                        <Columns>
                            <asp:BoundField DataField="name_user" HeaderText="Tên tài khoản" SortExpression="ma_donvi" />
                            <asp:BoundField DataField="tenhienthi" HeaderText="Tên hiển thị" SortExpression="ten_donvi" />
                            <asp:BoundField DataField="sdt" HeaderText="Số điện thoại" SortExpression="dia_chi" />
                            <asp:BoundField DataField="ten_donvi" HeaderText="Đơn vị" SortExpression="dia_chi" />
                            <asp:BoundField DataField="gioitinhA" HeaderText="Giới tính" SortExpression="dia_chi" />
                            <asp:BoundField DataField="name_super" HeaderText="Quyền hạn" SortExpression="dia_chi" />
                            <asp:BoundField DataField="khoa" HeaderText="Status khóa" SortExpression="dia_chi" />
                            <asp:BoundField DataField="xoa" HeaderText="Status Xóa" SortExpression="dia_chi" />
                            <asp:TemplateField HeaderText="Chức năng">
                                <ItemTemplate>
                                     <asp:LinkButton ID="btnReset" ValidationGroup="reset" runat="server" CommandArgument='<%#Eval("name_user") %>' CssClass="btn btn-secondary"  data-target="#myMoDelete" CommandName="resset" title="Cập nhật mật khẩu"><i class="fa fa-key"></i></asp:LinkButton>
                                     <asp:LinkButton ID="btnDelete" ValidationGroup="delete" runat="server" CommandArgument='<%#Eval("name_user") %>' CssClass="btn btn-danger"  data-target="#myMoDelete" title="Xóa tài khoản" CommandName="xoa"><i class="fa fa-trash" aria-hidden="true"></i></asp:LinkButton>
                                     <asp:LinkButton ID="btnRecycle" ValidationGroup="recy" runat="server" CommandArgument='<%#Eval("name_user") %>' CssClass="btn btn-success"  data-target="#myMoKP" title="Khôi phục tài khoản" CommandName="recory"><i class="fa fa-recycle" aria-hidden="true"></i></asp:LinkButton>
                                     <asp:LinkButton ID="btnKhoa" ValidationGroup="khoa" runat="server" CssClass="btn btn-warning"   CommandArgument='<%#Eval("name_user") %>' data-target="#myMoKhoa" title="Khóa cài khoản" CommandName="khoa"><i class="fa fa-lock"></i></asp:LinkButton>
                                     <asp:LinkButton ID="btunlock" ValidationGroup="khoa" runat="server" CssClass="btn btn-primary"   CommandArgument='<%#Eval("name_user") %>' data-target="#myMoUnlock" title="Mở cài khoản" CommandName="mo"><i class="fa fa-unlock"></i></asp:LinkButton>
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
                                        <asp:RequiredFieldValidator EnableClientScript="true" ValidationGroup="Popup"  ID="RequiredFieldValidator4" runat="server" ErrorMessage="Tên tài khoản không được bỏ trống !!!" ControlToValidate="txt_username" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                    <td style="padding-left:10px !important;">Tên hiển thị <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_name" runat="server" CssClass="form-control" placeholder="Nhập tên hiển thị"></asp:TextBox>
                                        <asp:RequiredFieldValidator EnableClientScript="true" ValidationGroup="Popup"  ID="RequiredFieldValidator1" runat="server" ErrorMessage="Tên hiển thị không được bỏ trống !!!" ControlToValidate="txt_name" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Mật khẩu<span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_password" runat="server" CssClass="form-control text-input" placeholder="Nhập mật khẩu" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator EnableClientScript="true" ValidationGroup="Popup"  ID="RequiredFieldValidator2" runat="server" ErrorMessage="Mật khẩu không được bỏ trống !!!" ControlToValidate="txt_password" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                        <asp:RequiredFieldValidator EnableClientScript="true" ValidationGroup="Popup"  ID="RequiredFieldValidator3" runat="server" ErrorMessage="Số điện thoại không được bỏ trống !!!" ControlToValidate="txt_sdt" Display="Dynamic"></asp:RequiredFieldValidator>
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
                            <asp:LinkButton ID="btnAdd" runat="server" ValidationGroup="Popup" CssClass="btn btn-success" OnClick="btnAdd_Click"><i class="fa fa-plus-circle"></i> Thêm tài khoản</asp:LinkButton>
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
                            <asp:LinkButton ID="btnResset" runat="server" CssClass="btn btn-success" ValidationGroup="Popup1" OnClick="btnResset_Click"><i class="fa fa-refresh"></i> Resset mật khẩu</asp:LinkButton>
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
                            <asp:LinkButton ID="btnDelete" ValidationGroup="Popup2" runat="server" CssClass="btn btn-success" OnClick="btnDelete_Click"><i class="fa fa-trash"></i> Xóa</asp:LinkButton>
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
                                <asp:LinkButton ID="btnKkhoaTK" ValidationGroup="Popup3" runat="server" CssClass="btn btn-success" OnClick="btnKkhoaTK_Click"><i class="fa fa-lock"></i> Khóa tài khoản</asp:LinkButton>
                                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                            </div>
                          </div>
      
                        </div>
                    </div><!--modal-khóa-->
                <div class="modal fade" id="myMoKP" role="dialog">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title">Thông báo</h4>
                            </div>
                            <div class="modal-body">
                                <asp:TextBox ID="TextBox1" runat="server" Visible="False"></asp:TextBox>
                               <h3>Bạn có muốn khôi phục tài khoản <asp:Label ID="title_kp" runat="server" Text="Label"></asp:Label> này không ?</h3>
                            </div>
                            <div class="modal-footer">
                                <asp:LinkButton ID="btnRecy" ValidationGroup="Popup5" runat="server" CssClass="btn btn-success" OnClick="btnRecy_Click"><i class="fa fa-recycle"></i> Khôi phục tài khoản</asp:LinkButton>
                                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                            </div>
                          </div>
      
                        </div>
                    </div><!--modal-khoiphuc-->
            <div class="modal fade" id="myMoUN" role="dialog">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title">Thông báo</h4>
                            </div>
                            <div class="modal-body">
                                <asp:TextBox ID="TextBox2" runat="server" Visible="False"></asp:TextBox>
                               <h3>Bạn có muốn mở tài khoản <asp:Label ID="title_un" runat="server" Text="Label"></asp:Label> này không ?</h3>
                            </div>
                            <div class="modal-footer">
                                <asp:LinkButton ID="Unlock" ValidationGroup="Popup5" runat="server" CssClass="btn btn-success" OnClick="Unlock_Click"><i class="fa fa-unlock"></i> Mở tài khoản</asp:LinkButton>
                                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                            </div>
                          </div>
      
                        </div>
                    </div><!--modal-khoiphuc-->
         </div><!--modal-->
    </form>
</asp:Content>
