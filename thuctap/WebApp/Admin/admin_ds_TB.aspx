﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_ds_TB.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.Admin.admin_ds_TB" %>
<asp:Content ID="Tb_1" ContentPlaceHolderID="headerTitle" runat="server">
            <title>VNPT - Quản lý thiết bị</title>
</asp:Content>
<asp:Content ID="Tb_2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
         <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/admin_ds_TB.aspx">Quản lý thiết bị</a>
                </div>
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myMoAdd"><i class="fa fa-plus-circle"></i> Thêm mới thiết bị</button>
                <button type="submit" class="btn btn-default" style="margin-left:10px;" onclick="return confirm('Bạn có muốn load lại trang không?');"><i class="fa fa-refresh"></i> Tải lại trang</button>
          </div>
          
         <div class="row">
             <div class="table-responsive">
                 <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" OnRowCommand="example_RowCommand" OnRowDataBound="example_RowDataBound">
                     <Columns>
                         <asp:BoundField DataField="ma_thietbi" HeaderText="Mã thiết bị" SortExpression="ma_thietbi" />
                         <asp:BoundField DataField="ten_thietbi" HeaderText="Tên thiết bị" SortExpression="ten_thietbi" />
                         <asp:BoundField DataField="soluong" HeaderText="Số lượng" SortExpression="so_luong" />
                         <asp:BoundField DataField="serinumber" HeaderText="Serinumber" SortExpression="serinumber" />
                         <asp:BoundField DataField="trang_thai" HeaderText="Trạng thái" SortExpression="id_loaitb" />
                         <asp:BoundField DataField="ten_tram" HeaderText="Tên trạm" SortExpression="id_tram" />                                                   
                         <asp:TemplateField HeaderText="Chức năng">
                            <ItemTemplate>
                               <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-primary" CommandArgument='<%#Eval("ma_thietbi") %>'  data-target="#myMoEdit" CommandName="chinhsua" UseSubmitBehavior="false"><i class="fa fa-edit"></i></asp:LinkButton>
                               <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%#Eval("ma_thietbi") %>' CssClass="btn btn-danger"  data-target="#myMoDelete" CommandName="xoa"><i class="fa fa-trash"></i></asp:LinkButton>
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
                    <div class="modal-dialog modal_login">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Thêm thiết bị mới</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <tr>
                                    <td>Mã thiết bị <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_matb" runat="server" CssClass="form-control text-input" placeholder="Nhập mã thiết bị"></asp:TextBox>
                                    </td>
                                    <td style="padding-left:10px !important;">Tên thiết bị <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_tentb" runat="server" CssClass="form-control" placeholder="Nhập tên thiết bị"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Đơn vị tính <span>*</span></td>
                                    <td>
                                         <asp:DropDownList ID="id_dvtinh" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </td>
                                    <td style="padding-left:10px !important;">Số lượng <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_soluong" runat="server" CssClass="form-control" placeholder="Nhập số lươợng" TextMode="Number"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Seri Number <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_seri" runat="server" CssClass="form-control text-input" placeholder="Nhập seri thiết bị"></asp:TextBox>
                                    </td>
                                    <td style="padding-left:10px !important;">Trạng thái <span>*</span></td>
                                    <td>
                                        <asp:DropDownList ID="trang_thai" runat="server" CssClass="form-control">
                                             <asp:ListItem Text="Hoạt động" Value="true"></asp:ListItem>
                                             <asp:ListItem Text="Không hoạt động" Value="false"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ngày nhận Tb <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="ngay_nhan" runat="server" CssClass="form-control text-input" TextMode="Date"></asp:TextBox>
                                    </td>
                                    <td style="padding-left:10px !important;">Loại thiết bị <span>*</span></td>
                                    <td>
                                         <asp:DropDownList ID="id_loaitb" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Nhà trạm <span>*</span></td>
                                    <td>
                                        <asp:DropDownList ID="id_tram" runat="server" CssClass="form-control"></asp:DropDownList>
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
                                    <td>Mã thiết bị <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_matb_edit" runat="server" CssClass="form-control text-input" placeholder="Nhập mã thiết bị" ReadOnly="true"></asp:TextBox>
                                    </td>
                                    <td style="padding-left:10px !important;">Tên thiết bị <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_tentb_edit" runat="server" CssClass="form-control" placeholder="Nhập tên thiết bị"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Đơn vị tính <span>*</span></td>
                                    <td>
                                         <asp:DropDownList ID="id_dvtinh_edit" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </td>
                                    <td style="padding-left:10px !important;">Số lượng <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_soluong_edit" runat="server" CssClass="form-control" placeholder="Nhập số lươợng" TextMode="Number"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Seri Number <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_seri_edit" runat="server" CssClass="form-control text-input" placeholder="Nhập seri thiết bị" ReadOnly="true"></asp:TextBox>
                                    </td>
                                    <td style="padding-left:10px !important;">Trạng thái <span>*</span></td>
                                    <td>
                                        <asp:DropDownList ID="trang_thai_edit" runat="server" CssClass="form-control">
                                             <asp:ListItem Text="Hoạt động" Value="true"></asp:ListItem>
                                             <asp:ListItem Text="Không hoạt động" Value="false"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ngày nhận Tb <span>*</span></td>
                                    <td>
                                        <asp:TextBox ID="txt_ngay_nhan_edit" runat="server" CssClass="form-control text-input" TextMode="Date" OnTextChanged="txt_ngay_nhan_edit_TextChanged"></asp:TextBox>
                                    </td>
                                    <td style="padding-left:10px !important;">Loại thiết bị <span>*</span></td>
                                    <td>
                                         <asp:DropDownList ID="id_loaitb_edit" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Nhà trạm <span>*</span></td>
                                    <td>
                                        <asp:DropDownList ID="id_tram_edit" runat="server" CssClass="form-control"></asp:DropDownList>
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
                          <h4 class="modal-title">Thông báo</h4>
                        </div>
                        <div class="modal-body">
                            <asp:TextBox ID="txt_delete" runat="server" Enabled="False" Visible="False"></asp:TextBox>
                            <h4 style="font-weight:normal;">Bạn có muốn xóa thiết bị <span style="padding-left:5px;padding-right:5px;color:#ff3333;"><asp:Label ID="txt_ten" runat="server" Text="Label"></asp:Label></span>không ?</h4>
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
