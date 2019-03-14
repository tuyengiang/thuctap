<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_notification.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.Admin.admin_notification" %>
<asp:Content ID="no_1" ContentPlaceHolderID="headerTitle" runat="server">
    <title>VNPT - Danh sách thông báo</title>
</asp:Content>
<asp:Content ID="no_2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
         <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/Admin/admin_notification.aspx">Danh sách thông báo</a>
                </div>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myMoAdd"><i class="fa fa-plus-circle"></i> Thêm mới thông báo</button>
                <button type="submit" class="btn btn-default" style="margin-left:10px;" onclick="return confirm('Bạn có muốn load lại trang không?');"><i class="fa fa-refresh"></i> Tải lại trang</button>
          </div><!--breadcrum-->
           <div class="row">
                <div class="table-responsive">
                      <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" OnRowCommand="example_RowCommand1" OnRowDataBound="example_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="title" HeaderText="Tên thông báo" SortExpression="ma_donvi" />
                                <asp:BoundField DataField="name_user" HeaderText="Người đăng" SortExpression="ten_donvi" />
                                <asp:BoundField DataField="created_at" HeaderText="Ngày đăng" SortExpression="dia_chi" />
                                <asp:BoundField DataField="updated_at" HeaderText="Ngày cập nhật" SortExpression="dia_chi" />
                                <asp:TemplateField HeaderText="Chức năng">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-primary" CommandArgument='<%#Eval("id") %>'  data-target="#myMoEdit" CommandName="chinhsua" UseSubmitBehavior="false"><i class="fa fa-edit"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%#Eval("id") %>' CssClass="btn btn-danger"  data-target="#myMoDelete" CommandName="xoa"><i class="fa fa-trash"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnView" runat="server" CommandArgument='<%#Eval("id") %>' CssClass="btn btn-success"  data-target="#myMoView" CommandName="view"><i class="fa fa-eye"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                             </Columns>
                       </asp:GridView>
                  </div>
            </div>
        <div class="row">
                <!-- Modal add -->
                  <div class="modal fade" id="myMoAdd" role="dialog">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Thêm mới thông báo</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>Tên thông báo <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_title" runat="server" CssClass="form-control text-input" placeholder="Nhập tên thông báo"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Nội dung <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_content" runat="server" CssClass="form-control" placeholder="Nhập nội dung thông báo" AutoPostBack="False" TextMode="MultiLine"></asp:TextBox>
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
                          <h4 class="modal-title">Sửa thông báo</h4>
                        </div>
                        <div class="modal-body">
                            <asp:TextBox ID="txt_id" runat="server" Visible="False"></asp:TextBox>
                               <table class="table">
                                <tr>
                                    <td>Tên thông báo <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_title_edit" runat="server" CssClass="form-control text-input" placeholder="Nhập tên thông báo"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Nội dung <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_content_edit" runat="server" CssClass="form-control" placeholder="Nhập nội dung thông báo" AutoPostBack="False" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success" OnClick="btnUpdate_Click"><i class="fa fa-save"></i> Cập nhật</asp:LinkButton>
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
                          <h4 class="modal-title">Đọc thông báo</h4>
                        </div>
                        <div class="modal-body">
                            <asp:TextBox ID="txt_delete" runat="server" Enabled="False" Visible="False"></asp:TextBox>
                            <h4 style="font-weight:normal;">Bạn có muốn thông báo <span style="padding-left:5px;padding-right:5px;color:#ff3333;"><asp:Label ID="txt_ten" runat="server" Text="Label"></asp:Label></span>không ?</h4>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnDelete_1" runat="server" CssClass="btn btn-success" OnClick="btnDelete_1_Click" ><i class="fa fa-trash"></i> Xóa</asp:LinkButton>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-delete-->
            <div class="modal fade" id="myMoView" role="dialog">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title"><asp:Label ID="title" runat="server" Text="Label"></asp:Label></h4>
                        </div>
                        <div class="modal-body"
                            <asp:Label ID="content" runat="server" Text="Label"></asp:Label>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-delete-->
            </div><!--modal-->
    </form>
</asp:Content>
