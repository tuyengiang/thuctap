<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_ds_don_vi.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.admin_ds_don_vi" %>

<asp:Content ID="don_vi_1" ContentPlaceHolderID="headerTitle" runat="server">
            <title>Quản lý danh sách đơn vị</title>
</asp:Content>
<asp:Content ID="don_vi_2" ContentPlaceHolderID="MainContent" runat="server">
     <form runat="server">
          <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx">Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/admin_ds_don_vi.aspx">Quản lý danh mục đơn vị</a>
                </div>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus-circle"></i> Thêm mới</button>

           </div>
            <div class="row">
                <!-- Modal -->
                  <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog">
                      <!-- Modal content-->
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Modal Header</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>Mã đơn bị</td>
                                    <td>
                                        <input type="text" class="form-control" placeholder="Nhập mã đơn vị" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Mã đơn bị</td>
                                    <td>
                                        <input type="text" class="form-control" placeholder="Nhập mã đơn vị" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Mã đơn bị</td>
                                    <td>
                                        <input type="text" class="form-control" placeholder="Nhập mã đơn vị" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Mã đơn bị</td>
                                    <td>
                                        <input type="text" class="form-control" placeholder="Nhập mã đơn vị" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-success"><i class="fa fa-save"></i> Thêm </button>
                          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div>
            </div>
         <div class="row">
                  <div class="table-responsive">
                        <table id="example" class="table table-bordered table-hover" style="width:100%">
                            <thead>
                            <tr>
                                <th>Mã đơn vị</th>
                                <th>Tên đơn vị</th>
                                <th>Địa chỉ</th>
                                <th>Mô tả</th>
                                <th>Chức Năng</th>
                            </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptData" runat="server">
                                   <ItemTemplate>
                                        <tr>
                                            <td><%#Eval("ma_donvi") %></td>
                                            <td><%#Eval("ten_donvi") %></td>
                                            <td><%#Eval("dia_chi") %></td>
                                            <td><%#Eval("mo_ta") %></td>
                                            <td>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success" data-toggle="modal" data-target="#myModal"><i class="fa fa-edit"></i></asp:LinkButton>
                                                <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-danger"><i class="fa fa-ban"></i></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                 </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
         </div>
     </form>
</asp:Content>
