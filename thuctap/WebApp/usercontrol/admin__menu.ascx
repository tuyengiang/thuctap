<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin__menu.ascx.cs" Inherits="WebApp.usercontrol.admin__menu" %>
 <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item nav-profile">
            <div class="nav-link">
              <div class="user-wrapper">
                <div class="profile-image">
                    <asp:Image ID="avatar_user" runat="server" />
                </div>
                <div class="text-wrapper">
                    <p class="profile-name">
                        <asp:Label ID="username" runat="server" Text="Label"></asp:Label>
                    </p>
                  <div>
                    <small class="designation text-muted">Đang hoạt động</small>
                    <span class="status-indicator online"></span>
                  </div>
                </div>
              </div>
            </div>
          </li>
            
            <asp:Repeater ID="rptMenu" runat="server" onitemdatabound="rptMenu_ItemDataBound"> 
                 <ItemTemplate>  
                        <li class="nav-item">
                            <a class="nav-link"  data-toggle='<%#Eval("toggle") %>' href='<%#Eval("link") %>' aria-expanded="false">
                              <i class="menu-icon <%#Eval("icon") %>"></i>
                              <span class="menu-title"><%#Eval("name") %></span>
                               <i class="<%#Eval("icon_angle") %>"></i>
                            </a>
                            <div class="collapse" id="<%#Eval("toggle_id") %>">
                                  <ul class="nav flex-column sub-menu">
                                       <asp:Repeater ID="rpt_Sub" runat="server">
                                            <ItemTemplate>
                                                <li class="nav-item">
                                                  <a class="nav-link" href='<%#Eval("link") %>'><i class="fa fa-circle-o" style="padding-right:5px;font-size:9px;"></i> <%#Eval("name") %></a>
                                                </li>
                                           </ItemTemplate>
                                       </asp:Repeater>
                                  </ul>
                            </div>
                        </li> 
                 </ItemTemplate>
             </asp:Repeater>
        </ul>
      </nav>