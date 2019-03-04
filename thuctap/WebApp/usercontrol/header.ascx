<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="header.ascx.cs" Inherits="WebApp.usercontrol.header" %>
<div class="header-top">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-8">

                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-4">
                        <div id="loginInfo">
                            <ul>
                                <li>Xin chào: <a href="/">Tuyển Giảng</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div><!--header-top-->
        <header id="header">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-2">
                       <div id="logo">
                            <a href="/"><h2>VNPT TB</h2></a>
                       </div>
                    </div>
                    <div class="col-md-8" id="header-center">
                        <div id="bar-mobile"><i class="fa fa-bars"></i></div>
                        <div class="header-menu">
                            <ul>
                                <li id="exit"><i class="fa fa-times"></i></li>
                                <li><a href="/"><i class="fa fa-home"></i> Trang chủ</a></li>
                                <li><a href="/">Quản lý thiết bị</a></li>
                                <li><a href="/">Quản lý danh mục <i class="fa fa-angle-down"></i></a>
                                     <ul class="sub-menu">
                                        <li><a href="/admin_ds_don_vi.aspx">Danh mục đơn vị</a></li>
                                        <li><a href="/admin_ds_nha_tram.aspx">Danh mục nhà trạm</a></li>
                                        <li><a href="#">Danh mục loại thiết bị</a></li>
                                    </ul>
                                </li>
                                <li><a href="/">Quản lý người dùng <i class="fa fa-angle-down"></i></a>
                                     <ul class="sub-menu">
                                        <li><a href="#">Thêm tài khoản mới</a></li>
                                        <li><a href="#">Danh Sách tài khoản</a></li>
                                    </ul>
                                </li>                                
                            </ul>
                        </div>
                    </div>
                    
                </div>
            </div>
        </header><!--header-->