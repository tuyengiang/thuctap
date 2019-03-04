<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_doimatkhau.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="MyNews.admin_doimatkhau" %>

<%@ Register Assembly="AjaxControlToolkit" TagPrefix="cc2" Namespace="AjaxControlToolkit" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc2:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnablePartialRendering="true"
        EnableScriptGlobalization="true" EnableScriptLocalization="true">
    </cc2:ToolkitScriptManager>

        <div class="container"  style="min-height:450px" >
            <div class="row" style="margin: 0px">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="row" style="margin: 0px">
                           <div class="title_top11">
                                <b>Đổi mật khẩu </b>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Mật khẩu cũ
                                </div>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtOldPass" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row" style="padding-top: 5px">
                                <div class="col-md-3">
                                    Mật khẩu mới
                                </div>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtNewPass" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row" style="padding-top: 5px">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-9">
                                    <asp:LinkButton ID="btnChange" OnClick="btnChange_Click" CssClass="btn btn-success" runat="server"> <i class="fa fa-save"></i> Cập nhật</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
        </div>
</asp:Content>
