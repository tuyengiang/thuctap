<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_ds_nhatram.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.Admin.admin_ds_nhatram" %>
<asp:Content ID="Tb_1" ContentPlaceHolderID="headerTitle" runat="server">
            <title>VNPT - Quản lý nhà trạm</title>
</asp:Content>
<asp:Content ID="Tb_2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
       <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/admin_ds_nhatram.aspx">Quản lý nhà trạm</a>
                </div>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myMoAdd"><i class="fa fa-plus-circle"></i> Thêm mới nhà trạm</button>
          </div>
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
                        <asp:ListItem Text="Mã nhà trạm" Value="madv"></asp:ListItem>
                        <asp:ListItem Text="Tên nhà trạm" Value="tendv"></asp:ListItem>
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
                 <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" OnRowCommand="example_RowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="example_PageIndexChanging" >
                     <Columns>
                         <asp:BoundField DataField="ma_tran" HeaderText="Mã nhà trạm" SortExpression="ma_thietbi" />
                         <asp:BoundField DataField="ten_tram" HeaderText="Tên nhà trạm" SortExpression="ten_thietbi" />
                         <asp:BoundField DataField="ten_donvi" HeaderText="Đơn vị" SortExpression="so_luong" />
                         <asp:HyperlinkField datatextfield="Soluong" headertext="Số lượng" Target="_Blank" DataNavigateUrlFields="ma_tran" DataNavigateUrlFormatString="/Admin/admin_ds_TB.aspx?ma_tran={0}"/>
                         <asp:BoundField DataField="dia_chi" HeaderText="Địa chỉ" SortExpression="serinumber" />
                         <asp:BoundField DataField="mo_ta" HeaderText="Mô tả" SortExpression="id_loaitb" />                                                
                         <asp:TemplateField HeaderText="Chức năng">
                            <ItemTemplate>
                               <asp:LinkButton ID="btnEdit"  ValidationGroup="Edit" runat="server" CssClass="btn btn-primary" CommandArgument='<%#Eval("ma_tran") %>'  data-target="#myMoEdit" CommandName="chinhsua" UseSubmitBehavior="false"><i class="fa fa-edit"></i></asp:LinkButton>
                               <asp:LinkButton ID="btnDelete"  ValidationGroup="Delete" runat="server" CommandArgument='<%#Eval("ma_tran") %>' CssClass="btn btn-danger"  data-target="#myMoDelete" CommandName="xoa"><i class="fa fa-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                 </asp:GridView>
                </div>
            </div>
            <!--modal-->
          <div class="row">
                <!-- Modal add -->
                  <div class="modal fade" id="myMoAdd" role="dialog">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Thêm mới nhà trạm</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>Mã nhà trạm <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_matram" runat="server" CssClass="form-control text-input" placeholder="Nhập mã nhà trạm"></asp:TextBox>
                                        <asp:RequiredFieldValidator EnableClientScript="true" ValidationGroup="Popup"  ID="RequiredFieldValidator4" runat="server" ErrorMessage="Mã trạm không được bỏ trống !!!" ControlToValidate="txt_matram" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tên nhà trạm <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_tentram" runat="server" CssClass="form-control" placeholder="Nhập tên nhà trạm"></asp:TextBox>
                                        <asp:RequiredFieldValidator EnableClientScript="true" ValidationGroup="Popup"  ID="RequiredFieldValidator1" runat="server" ErrorMessage="Tên trạm không được bỏ trống !!!" ControlToValidate="txt_tentram" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>Đơn vị <span>*</span></td>
                                    <td>
                                        <asp:DropDownList ID="id_donviSelect" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>Địa chỉ <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_diachi" runat="server" CssClass="form-control" placeholder="Nhập địa chỉ nhà trạm"></asp:TextBox>
                                        <asp:RequiredFieldValidator EnableClientScript="true" ValidationGroup="Popup"  ID="RequiredFieldValidator2" runat="server" ErrorMessage="Địa chỉ không được bỏ trống !!!" ControlToValidate="txt_diachi" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>Mô tả <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_mota" runat="server" CssClass="form-control" placeholder="Nhập mô tả nhà trạm"></asp:TextBox>
                                        <asp:RequiredFieldValidator EnableClientScript="true" ValidationGroup="Popup"  ID="RequiredFieldValidator3" runat="server" ErrorMessage="Mô tả không được bỏ trống !!!" ControlToValidate="txt_mota" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnAdd" runat="server" ValidationGroup="Popup" CssClass="btn btn-success" OnClick="btnAdd_Click"><i class="fa fa-plus-circle"></i> Thêm mới </asp:LinkButton>
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
                          <h4 class="modal-title">Sửa thiết bị</h4>
                        </div>
                        <div class="modal-body">
                              <table class="table">
                                <tr>
                                    <td>Mã nhà trạm <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_ma_edit" runat="server" CssClass="form-control text-input" placeholder="Nhập mã nhà trạm" ReadOnly="true"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Tên đơn vị không được bỏ trống !!!" ControlToValidate="txt_ma_edit" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tên nhà trạm <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_ten_edit" runat="server" CssClass="form-control" placeholder="Nhập tên nhà trạm"></asp:TextBox>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>Đơn vị <span>*</span></td>
                                    <td>
                                        <asp:DropDownList ID="id_donvi_edit" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>Địa chỉ <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_diachi_edit" runat="server" CssClass="form-control" placeholder="Nhập địa chỉ nhà trạm"></asp:TextBox>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>Mô tả <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_mota_edit" runat="server" CssClass="form-control" placeholder="Nhập mô tả nhà trạm"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success" Onclick="btnUpdate_Click"><i class="fa fa-save"></i> Cập nhật</asp:LinkButton>
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
                            <h4 style="font-weight:normal;">Bạn có muốn xóa trạm <span style="padding-left:5px;padding-right:5px;color:#ff3333;"><asp:Label ID="txt_ten" runat="server" Text="Label"></asp:Label></span>không ?</h4>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnDelete_1" runat="server" CssClass="btn btn-success" OnClick="btnDelete_1_Click"><i class="fa fa-trash"></i> Xóa</asp:LinkButton>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-delete-->
            </div><!--modal-->

    </form>
</asp:Content>
