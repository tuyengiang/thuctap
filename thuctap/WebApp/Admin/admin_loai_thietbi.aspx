<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_loai_thietbi.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.Admin.admin_loai_thietbi" %>
<asp:Content ID="loai_Tb_1" ContentPlaceHolderID="headerTitle" runat="server">
    <title>VNPT - Quản lý danh loại thiết bị</title>
</asp:Content>
<asp:Content ID="loai_Tb_2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
         <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/Admin/admin_ds_don_vi.aspx">Quản lý danh mục loại thiết bị</a>
                </div>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus-circle"></i> Thêm mới loại thiết bị</button>
         </div><!--breadcrum-->
         <div class="row" id="form">
            <div class="col-xs-12 col-sm-12 col-md-4"></div>
            <div class="col-xs-12 col-sm-12 col-md-3">
                <div class="form-group">
                     <asp:DropDownList ID="searchSelect" runat="server" CssClass="form-control">
                        <asp:ListItem Text="--- Tìm kiếm theo ---" Value="NULL"></asp:ListItem>
                        <asp:ListItem Text="Mã loại thiết bị" Value="maloai"></asp:ListItem>
                        <asp:ListItem Text="Tên loại thiết bị" Value="tenloai"></asp:ListItem>
                     </asp:DropDownList>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-3">
                <div class="form-group">
                   <asp:TextBox ID="inputSearch" runat="server" CssClass="form-control" placeholder="Nhập từ khóa tìm kiếm"></asp:TextBox>
                </div>
             </div>
            <div class="col-xs-12 col-sm-12 col-md-2">
                <span><asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click"><i class="fa fa-search"></i></asp:LinkButton></span>
                <span><asp:LinkButton ID="btn_refresh" runat="server" CssClass="btn btn-success" OnClick="btn_refresh_Click"><i class="fa fa-refresh"></i> Refresh</asp:LinkButton></span>
            </div>
      </div>
        <!--list-->
        <div class="row">
                  <div class="table-responsive">
                        <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" onrowcommand="example_RowCommand">
                            <Columns>
                               <asp:BoundField DataField="ma_loaiTB" HeaderText="Mã loại TB" SortExpression="ma_donvi" />
                               <asp:BoundField DataField="ten_loaiTB" HeaderText="Tên loại TB" SortExpression="ten_donvi" />
                               <asp:BoundField DataField="trang_thaiA" HeaderText="Tình trạng" SortExpression="dia_chi" />
                               <asp:BoundField DataField="mota_tb" HeaderText="Mô tả" SortExpression="dia_chi" />
                               <asp:TemplateField HeaderText="Chức năng">
                                   <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-primary" CommandArgument='<%#Eval("ma_loaiTB") %>'  data-target="#myMoEdit" CommandName="chinhsua" UseSubmitBehavior="false"><i class="fa fa-edit"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%#Eval("ma_loaiTB") %>' CssClass="btn btn-danger"  data-target="#myMoDelete" CommandName="xoa"><i class="fa fa-trash"></i></asp:LinkButton>
                                   </ItemTemplate>
                               </asp:TemplateField>
                           </Columns>
                       </asp:GridView>
                   </div>
                            
            </div>
         <div class="row">
                <!-- Modal add -->
                  <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Thêm đơn loại thiết bị mới</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>Mã loại TB <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_maloaiTB" runat="server" CssClass="form-control text-input" placeholder="Nhập mã loại thiết bị"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tên loại TB <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_tenloaiTB" runat="server" CssClass="form-control" placeholder="Nhập tên loại thiết bị"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Trạng thái<span>*</span></td>
                                    <td>
                                        <asp:DropDownList ID="trang_thai" runat="server" CssClass="form-control">
                                             <asp:ListItem Text="Có thiết bị" Value="true"></asp:ListItem>
                                             <asp:ListItem Text="Không có thiết bị" Value="false"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Mô tả</td>
                                    <td>
                                        <asp:TextBox ID="txt_mota" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Nhập mô tả"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-success" OnClick="btnAdd_Click"><i class="fa fa-plus-circle"></i> Thêm mới</asp:LinkButton>
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
                          <h4 class="modal-title">Sửa loại thiết bị</h4>
                        </div>
                        <div class="modal-body">
                                        <table class="table">
                                            <tr>
                                                <td>Mã loại TB <span>*</span></td>
                                                <td>
                                                    <asp:TextBox ID="txt_maloaiTB_edit" runat="server" CssClass="form-control text-input" placeholder="Nhập mã đơn vị" ReadOnly="true"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Tên loaiTB <span>*</span></td>
                                                <td>
                                                    <asp:TextBox ID="txt_tenloaiTB_edit" runat="server" CssClass="form-control" placeholder="Nhập tên đơn vị"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Trạng thái<span>*</span></td>
                                                <td>
                                                    <asp:DropDownList ID="trang_thai_edit" runat="server" CssClass="form-control">
                                                         <asp:ListItem Text="Có thiết bị" Value="true"></asp:ListItem>
                                                          <asp:ListItem Text="Không có thiết bị" Value="false"></asp:ListItem>
                                                    </asp:DropDownList>
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
                            <asp:LinkButton ID="btnEditChange" runat="server" CssClass="btn btn-success" OnClick="btnEditChange_Click"><i class="fa fa-save"></i> Cập nhật</asp:LinkButton>
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
                            <h4 style="font-weight:normal;">Bạn có muốn xóa loại thiết bị <span style="padding-left:5px;padding-right:5px;color:#ff3333;"><asp:Label ID="txt_ten" runat="server" Text="Label"></asp:Label></span>không ?</h4>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnDelete_1" runat="server" CssClass="btn btn-success" OnClick="btnDelete_Click"><i class="fa fa-trash"></i> Xóa</asp:LinkButton>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-delete-->
            </div><!--modal-->
    </form>
</asp:Content>