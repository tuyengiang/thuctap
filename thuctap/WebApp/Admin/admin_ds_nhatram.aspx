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
                <button type="submit" class="btn btn-default" style="margin-left:10px;" onclick="return confirm('Bạn có muốn load lại trang không?');"><i class="fa fa-refresh"></i> Tải lại trang</button>
          </div>
        
         <div class="row">
             <div class="table-responsive">
                 <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" OnRowCommand="example_RowCommand" AllowPaging="True" PageSize="8"  OnRowDataBound="example_RowDataBound">
                     <Columns>
                         <asp:BoundField DataField="ma_tran" HeaderText="Mã nhà trạm" SortExpression="ma_thietbi" />
                         <asp:BoundField DataField="ten_tram" HeaderText="Tên nhà trạm" SortExpression="ten_thietbi" />
                         <asp:BoundField DataField="ten_donvi" HeaderText="Đơn vị" SortExpression="so_luong" />
                         <asp:BoundField DataField="dia_chi" HeaderText="Địa chỉ" SortExpression="serinumber" />
                         <asp:BoundField DataField="mo_ta" HeaderText="Mô tả" SortExpression="id_loaitb" />                                                
                         <asp:TemplateField HeaderText="Chức năng">
                            <ItemTemplate>
                               <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-primary" CommandArgument='<%#Eval("ma_tran") %>'  data-target="#myMoEdit" CommandName="chinhsua" UseSubmitBehavior="false"><i class="fa fa-edit"></i></asp:LinkButton>
                               <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%#Eval("ma_tran") %>' CssClass="btn btn-danger"  data-target="#myMoDelete" CommandName="xoa"><i class="fa fa-trash"></i></asp:LinkButton>
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
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tên nhà trạm <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_tentram" runat="server" CssClass="form-control" placeholder="Nhập tên nhà trạm"></asp:TextBox>
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
                                    </td>
                                </tr>
                                 <tr>
                                    <td>Mô tả <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_mota" runat="server" CssClass="form-control" placeholder="Nhập mô tả nhà trạm"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-success" OnClick="btnAdd_Click"><i class="fa fa-plus-circle"></i> Thêm mới </asp:LinkButton>
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
