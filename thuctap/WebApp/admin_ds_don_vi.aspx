<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_ds_don_vi.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.admin_ds_don_vi" %>

<asp:Content ID="don_vi_1" ContentPlaceHolderID="headerTitle" runat="server">
            <title>VNPT - Quản lý danh sách đơn vị</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="scriptMain" runat="server">
  
</asp:Content>
<asp:Content ID="don_vi_2" ContentPlaceHolderID="MainContent" runat="server">
     <form runat="server" id="myform" name="registration">
          <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/admin_ds_don_vi.aspx">Quản lý danh mục đơn vị</a>
                </div>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myMoAdd"><i class="fa fa-plus-circle"></i> Thêm mới đơn vị</button>
          </div>
         <div class="row" id="form">
            <div class="col-xs-12 col-sm-12 col-md-4"></div>
            <div class="col-xs-12 col-sm-12 col-md-3">
                <div class="form-group">
                     <asp:DropDownList ID="searchSelect" runat="server" CssClass="form-control">
                        <asp:ListItem Text="--- Tìm kiếm theo ---" Value="NULL"></asp:ListItem>
                        <asp:ListItem Text="Mã đơn vị" Value="madv"></asp:ListItem>
                        <asp:ListItem Text="Tên đơn vị" Value="tendv"></asp:ListItem>
                        <asp:ListItem Text="Địa chỉ" Value="diachi"></asp:ListItem>
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
                 <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" onrowcommand="example_RowCommand" AllowPaging="True" OnPageIndexChanging="example_PageIndexChanging" PageSize="10">
                     <Columns>
                         <asp:BoundField DataField="ma_donvi" HeaderText="Mã đơn vị" SortExpression="ma_donvi" />
                         <asp:BoundField DataField="ten_donvi" HeaderText="Tên đơn vị" SortExpression="ten_donvi" />
                         <asp:BoundField DataField="dia_chi" HeaderText="Địa chỉ" SortExpression="dia_chi" />
                         <asp:BoundField DataField="mo_ta" HeaderText="Mô tả" SortExpression="dia_chi" />
                         <asp:TemplateField HeaderText="Chức năng">
                            <ItemTemplate>
                               <asp:LinkButton ID="btnEdit" runat="server"  ValidationGroup="Edit" CssClass="btn btn-primary" CommandArgument='<%#Eval("ma_donvi") %>'  data-target="#myMoEdit" CommandName="chinhsua" UseSubmitBehavior="false"><i class="fa fa-edit"></i></asp:LinkButton>
                               <asp:LinkButton ID="btnDelete" runat="server"  ValidationGroup="Delete" CommandArgument='<%#Eval("ma_donvi") %>' CssClass="btn btn-danger"  data-target="#myMoDelete" CommandName="xoa"><i class="fa fa-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                 </asp:GridView>
                </div>
            </div>
         <!--modal-->
          <div class="row">
                <!-- Modal add -->
                  <div class="modal fade" id="myMoAdd" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Thêm loại thiết bị mới</h4>
                        </div>
                        <div class="modal-body">
                                <table class="table">
                                    <tr>
                                        <td>Mã đơn bị <span>*</span></td>
                                        <td>
                                            <asp:TextBox ID="txt_madv"  runat="server" CssClass="form-control text-input" placeholder="Nhập mã đơn vị"></asp:TextBox>
                                            <asp:RequiredFieldValidator  ValidationGroup="Popup" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Mã đơn vị không được bỏ trống !!!" ControlToValidate="txt_madv" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Tên đơn bị <span>*</span></td>
                                        <td>
                                            <asp:TextBox ID="txt_tendv" runat="server" CssClass="form-control" placeholder="Nhập tên đơn vị"></asp:TextBox>
                                            <asp:RequiredFieldValidator  ValidationGroup="Popup" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Tên đơn vị không được bỏ trống !!!" ControlToValidate="txt_tendv" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Địa chỉ <span>*</span></td>
                                        <td>
                                            <asp:TextBox ID="txt_diachi" runat="server" CssClass="form-control" placeholder="Nhập địa chỉ"></asp:TextBox>
                                            <asp:RequiredFieldValidator  ValidationGroup="Popup" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Địa chỉ đơn vị không được bỏ trống !!!" ControlToValidate="txt_diachi" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Mô tả</td>
                                        <td>
                                            <asp:TextBox ID="txt_mota" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Nhập mô tả"></asp:TextBox>
                                            <asp:RequiredFieldValidator  ValidationGroup="Popup" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Mô tả đơn vị không được bỏ trống !!!" ControlToValidate="txt_mota" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnAdd" runat="server"  ValidationGroup="Popup" CssClass="btn btn-success" OnClick="btnAdd_Click"><i class="fa fa-plus-circle"></i> Thêm mới </asp:LinkButton>
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
                          <h4 class="modal-title">Sửa đơn vị</h4>
                        </div>
                        <div class="modal-body">
                                        <table class="table">
                                            <tr>
                                                <td>Mã đơn bị <span>*</span></td>
                                                <td>
                                                    <asp:TextBox ID="txt_madv_edit" runat="server" CssClass="form-control text-input" placeholder="Nhập mã đơn vị" ReadOnly="True"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Tên đơn bị <span>*</span></td>
                                                <td>
                                                    <asp:TextBox ID="txt_tendv_edit" runat="server" CssClass="form-control" placeholder="Nhập tên đơn vị"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Địa chỉ <span>*</span></td>
                                                <td>
                                                    <asp:TextBox ID="txt_diachi_edit" runat="server" CssClass="form-control" placeholder="Nhập địa chỉ"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Mô tả</td>
                                                <td>
                                                    <asp:TextBox ID="txt_mota_edit" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Nhập mô tả"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success" OnClick="btnEdit_Click"><i class="fa fa-save"></i> Cập nhật</asp:LinkButton>
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
                            <asp:TextBox ID="txt_delete" runat="server" Enabled="False" Visible="False"></asp:TextBox>
                            <h4 style="font-weight:normal;">Bạn có muốn xóa đơn vị <span style="padding-left:5px;padding-right:5px;color:#ff3333;"><asp:Label ID="txt_ten" runat="server" Text="Label"></asp:Label></span>không ?</h4>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnDelete_1" runat="server" CssClass="btn btn-success" OnClick="btnDelete_Click1"><i class="fa fa-trash"></i> Xóa</asp:LinkButton>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-delete-->
            </div><!--modal-->
     </form>
</asp:Content>
