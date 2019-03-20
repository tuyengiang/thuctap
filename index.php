<?php

// debug
// ini_set('display_error' , '1');
// error_reporting(E_ALL);

// // //disable debug 
ini_set('display_error' , '0');
error_reporting(0);


//phpinfo();die;
#include_once "laivt_firewall.php";
// include_once "anti_ddos.php";

if(isset($_GET['captcha'])){
session_start();
$date=date('H');
$text=rand(10000,99999);
$_SESSION["code"]=$text;
 $width = 60;
    $height = 15;
    $fontsize = 35;

    $img = imagecreate($width, $height);

    // Transparent background
    $black = imagecolorallocate($img, 0, 0, 0);
    imagecolortransparent($img, $black);

    // Red text
    $red = imagecolorallocate($img, 230, 115, 150);
    imagestring($img, $fontsize, 0, 0, $text, $red);

    header('Content-type: image/png');
    imagepng($img);
    imagedestroy($img);
exit;}

$conf="'Xóa bài bài viết này?'";
require('incfiles/functions.php');
require('incfiles/bbcode.php');

//Chmod bao mat
if(isset($admin)){
chmod("incfiles/config.php",0400); }

$title=set('title');
$desc=set('desc');
$path='home';









/*####### Phần chat #########*/







if(isset($_GET['submit'])){


if(empty($acc_id)){
echo 'Bạn chưa đăng nhập';
exit;};

if($acc_antispam>time()){
if(isset($_POST['contents'])){
echo '<script>
 document.getElementById("contents").value = "'.$_POST['contents'].'";
</script>';}

$sec=$acc_antispam-time();
echo '<div class="list2" style="color:red">• Vui lòng đăng tiếp sau '.$sec.' giây nữa</div>';
exit;
}
if(empty($_POST['contents'])){
echo '<div class="list2" style="color:red">• Vui lòng nhập nội dung bình luận</div>';
exit;}

if(strlen($_POST['contents'])<4){
echo '<div class="list2" style="color:red">• Nội dung phải có ít nhất 3 từ</div>';
exit;}

if(strlen($_POST['contents'])>10000){
echo '<div class="list2" style="color:red">• Nội dung phải có ít hơn 10000 từ</div>';
exit;}

if(isset($_POST['chot']))
{
	$type='chot';
	if(isset($_POST['cbtl'])){$btl = $_POST['cbtl'];}else{$btl = 0;}
	
	if(isset($_POST['cstl'])){$stl = $_POST['cstl'];}else{$stl = 0;}
	
	if(isset($_POST['cxien'])){$xien = $_POST['cxien'];}else{$xien = 0;}
	
	if(isset($_POST['clodan'])){$lodan = $_POST['clodan'];}else{$lodan = 0;}
	
	if(isset($_POST['cdedan'])){$dedan = $_POST['cdedan'];}else{$dedan = 0;}
	
	if(isset($_POST['clonuoi'])){$lonuoi = $_POST['clonuoi'];}else{$lonuoi = 0;}
	
	if(isset($_POST['cdenuoi'])){$denuoi = $_POST['cdenuoi'];}else{$denuoi = 0;}
	
}
else
{
	$type='chat';
}
$query = "INSERT INTO `chat` SET 
	`acc` = '$acc_id',
	`btl` = '$btl',
	`stl` = '$stl',
	`xien` = '$xien',
	`lodan` = '$lodan',
	`dedan` = '$dedan',
	`lonuoi` = '$lonuoi',
	`denuoi` = '$denuoi',
    `text` = '".strip_tags($_POST['contents'])."',
    `time` = '" . time() . "',
    `type` = '".$type."'";

// echo ($query);
mysql_query($query);
// die('run :V ');
	
mysql_query("UPDATE `account` SET `antispam`='" . (time()+20) . "' WHERE `id` = '".$acc_id."'");
echo '<div class="list2" style="color:blue">• Đã gửi nội dung thành công</div>';
exit;
}







if(isset($admin) && isset($_GET['empty'])){

if($_GET['empty']=='chat_30day'){
mysql_query("DELETE FROM `chat` WHERE `time` < ".(time()-2600000)."");

}else{
mysql_query("DELETE FROM  `chat` WHERE `type`='".$_GET['empty']."'");}

echo '<script language="JavaScript1.1">
alert("• Dọn phòng chat thành công")
</script>';
echo '<script type="text/javascript">
window.location.href = "/#chat"
</script>';

}
if(isset($admin) && isset($_GET['del'])){

mysql_query("DELETE FROM `chat` WHERE `id`='".$_GET['del']."'");

mysql_query("DELETE FROM `chat` WHERE `refid`='".$_GET['del']."'");
echo '<script language="JavaScript1.1">
alert("• Xóa bài chat thành công")
</script>';
echo '<script type="text/javascript">
window.location.href = "/#chat"
</script>';
}













$addtag='<script src="/js/index.js" ></script>';
require('incfiles/header.php');



if(isset($acc_id) && isset($_GET['like'])){

$gtag = mysql_query("SELECT * FROM `chat` WHERE `id`='".$_GET['like']."'");
if(mysql_num_rows($gtag)!=0){

while ($tag = mysql_fetch_assoc($gtag)) {
if(!preg_match("#-".$acc_id."-#is", $tag['liked'])){
if($acc_id!=$tag['acc']){

  mysql_query("UPDATE `account` SET `liked`='" . (acc($tag['acc'],'liked')+1) . "' WHERE `id` = '".$tag['acc']."'");
  mysql_query("UPDATE `chat` SET `like`='" . ($tag['like']+1) . "',`liked`='".$tag['liked']."-".$acc_id."-,' WHERE `id` = '".$_GET['like']."'");
}
}
echo '<script type="text/javascript">
window.location.href = "/#chat'.$_GET['like'].'"
</script>';
}}




exit;
}







if(isset($acc_id) && isset($_GET['unlike'])){

$gtag = mysql_query("SELECT * FROM `chat` WHERE `id`='".$_GET['unlike']."'");
if(mysql_num_rows($gtag)!=0){

while ($tag = mysql_fetch_assoc($gtag)) {
if(preg_match("#-".$acc_id."-#is", $tag['liked'])){
if($acc_id!=$tag['acc']){
$rep=str_replace("-".$acc_id."-,","", $tag["liked"]);
  mysql_query("UPDATE `chat` SET `like`='" . ($tag['like']-1) . "',`liked`='".$rep."' WHERE `id` = '".$_GET['unlike']."'");
  mysql_query("UPDATE `account` SET `liked`='" . (acc($tag['acc'],'liked')-1) . "' WHERE `id` = '".$tag['acc']."'");
}
}
echo '<script type="text/javascript">
window.location.href = "/#chat'.$_GET['unlike'].'"
</script>';
}}




exit;
}









if(isset($acc_id) && isset($_GET['edit'])){


$gtag = mysql_query("SELECT * FROM `chat` WHERE `id`='".$_GET['edit']."' ORDER BY `time` ASC LIMIT 1");
if(mysql_num_rows($gtag)!=0){
while ($tag = mysql_fetch_assoc($gtag)) {

if($tag['acc']!=$acc_id){
echo '<div class="rmenu">Bạn không thể chỉnh sửa bài người khác</div>';
exit;}

if(isset($_POST['text'])){
  mysql_query("UPDATE `chat` SET `text`='" . strip_tags($_POST['text']) . "' WHERE `id` = '".$_GET['edit']."'");
echo '<script language="JavaScript1.1">
alert("• Chỉnh sửa đã được lưu lại")
</script>';
echo '<script type="text/javascript">
window.location.href = "/#chat"
</script>';

exit;
}
echo '<form action="" method="post"/>
<div class="menusmall"><textarea style="width:80%" rows="8" name="text">'.$tag['text'].'</textarea></div>
<div class="menu"><input type="submit" value="Chỉnh sửa"/></div></form>
';}

}

require('incfiles/footer.php');
exit;

}


if(isset($acc_id)){
echo'
 <div id="infoheader"><p>Thành viên: <a  href="#">'.$acc_nick.''.($msg_st==0 ? '' : '<span style="color:red;font-size:small">•</span>').'</a>
  | <a title="trang ca nhân" href="/users/profile.htm"> Thông Tin Cá Nhân</a><br>

Số Tiền: <b>'.money($acc_money).' Xu | <a title="Nạp thêm tiền vào tài khoản" href="/naptien">Nạp thêm xu</a></b>|<a title="Đăng xuất " href="/users/profile.htm?logout"">Thoát</a></div>
';
}

if(isset($mobile)){

//Phần hiển thị trên mobi
// if(empty($acc_id)){
if(true){


 require_once('textlink.php');

}


}else{ 

//Phần hiển thị trên may tinh
// if(empty($acc_id)){
if(true){


 require_once('textlink.php');

}

}

if(empty($acc_id)){
echo '<p class="text_red"></p><p class="text_red"></p>
<div class="title_mid">
<p class="text_red"></p><h1>
Soi Cầu Lấy Số Đẹp Ngày '.$dateday.'  </h1><p></p>
<div class="clear"></div>
</div> <div class="module" id="thayba">
<div class="row">
<div class="col-lg-12"> 
</div> </div><div class="row">
<div class="col-lg-12">
<span class="pull-right">
<span class="pull-right"><a class="btn btn-warning" style="color:#fff;" href="/users/login.htm" class="btn btn-warning">Bấm vào đây để đăng nhập xem số VIP </a></span><br><br>
 </div>
</div></div>
<br><br>';

echo'<div class="clear"></div>
 <div class="batung" id="thayba">
<div class="row">
<div class="col-lg-12"> 
</div> </div><div class="row">
<div class="col-lg-12">
<span class="pull-right">
<span class="pull-right"><a href="/users/register.htm" data-g="" data-s="" class="btn btn-sm btn-success" style="color:#fff;"  class="btn btn-sm btn-success">Bấm vào đây để đăng ký thành viên</a></span><br><br>
 </div>
</div>
</div><br><br>';

}



if(isset($acc_id)){
// Mua soi cau vip
echo '<br><br><div class="title_mid">
<p class="text_red"></p><h1> 
Soi Cầu Lấy Số Đẹp Ngày '.$dateday.' </h1><p></p>
<div class="clear"></div>
</div> ';

if(isset($_GET['muavip'])){
if($acc_money>set('soivip_gia')){
 mysql_query("UPDATE `account` SET `soivip`='$dateiday' WHERE `id` = '$acc_id'");
 mysql_query("UPDATE `account` SET `money`='".($acc_money-set('soivip_gia'))."' WHERE `id` = '$acc_id'");// Gia mua goi soi vip la 10k
echo '<script language="JavaScript1.1">
alert("• Cảm ơn bạn đã mua gói soi vip ngày '.$dateday.'")
</script>';
echo '<script type="text/javascript">
window.location.href = "/"
</script>';
}else{echo '<script language="JavaScript1.1">
alert("• Bạn không đủ '.money(set('soivip_gia')).' để mua gói soi vip")
</script>';
echo '<script type="text/javascript">
window.location.href = "/"
</script>';

exit;}
exit;}
if(!isset($admin)){
if($acc_soivip==set('soivip_date')){
echo '<div class="module" id="thayba">
<div class="row">
<div class="col-lg-12">
</div> </div>
<div class="row">
<div class="col-lg-12">
<span class="pull-right">
<span class="btn btn-sm btn-success"> Dàn: '.$soivip_xs.'</span><br><br>
 </div>
</div>
</div>';

echo '<div class="batung" id="thayba">
<div class="row">
<div class="col-lg-12"> 
</div> </div>
<div class="row">
<div class="col-lg-12">
<span class="pull-right">
<span class="btn btn-sm btn-success">
Cặp: '.$soivip_lo.'</span><br><br>
 </div>
</div>
</div></div><div class="clear"></div>';

echo '<div class="rmenu">
    (*).Cảm ơn bạn đã mua gói soi số vip, thông tin chỉ tham khảo với tỉ lệ trúng là 85%
</div>
';
}else{
echo '<div class="module" id="thayba">
<div class="row">
<div class="col-lg-12"> 
</div> </div><div class="row">
<div class="col-lg-12">
<span class="pull-right">
<span class="pull-right"><a '.(isset($mobile) ? 'style="color:#ff00ff"' :'class="btn btn-warning" style="color:#fff;"').' href="/sovip" target="_blank" class="btn btn-warning">Bấm vào đây để vào lấy số VIP tham khảo Đặc Biệt </a></span><br><br>
 </div>
</div>
</div>
<br><br>
<br>
<div class="batung" id="thayba">
<div class="row">
<div class="col-lg-12">
</div> </div><div class="row">
<div class="col-lg-12">
<span class="pull-right">
<span class="pull-right"><a '.(isset($mobile) ? 'style="color:#ff00ff"' :'class="btn btn-warning loading" style="color:#fff;"').' href="/sovip" target="_blank"  class="btn btn-warning loading">Bấm vào đây để vào lấy số VIP tham khảo Loto </a></span><br><br>
 </div>
</div>
</div>
<br><br>
<br>

';
}
}else{

if(isset($_POST['sv_result'])){
mysql_query("UPDATE `settings` SET `value`='".$_POST['xoso']."|".$_POST['loto']."' WHERE `key` = 'soivip_number'");
mysql_query("UPDATE `settings` SET `value`='".($_POST['gia'] < 1000 ? '1000' : $_POST['gia'])."' WHERE `key` = 'soivip_gia'");
echo '<script language="JavaScript1.1">
alert("• Ðã lưu kết quả soi vip ngày '.$dateday.'")
</script>';
echo '<script type="text/javascript">
window.location.href = "/"
</script>';
exit;
}

echo '<form action="" method="POST"/>
<div class="menu">Xổ số: <input type="text" name="xoso" value="'.$soivip_xs.'"/></div>
<div class="menu">Lô tô: <input type="text" name="loto" value="'.$soivip_lo.'"/></div>
<div class="menu">Giá mua: <input type="text" name="gia" value="'.set('soivip_gia').'"/></div>
<div class="rmenu">
  <input type="submit" name="sv_result" value="Cập nhật số VIP"/>
  </form>
</div>
';
}



}





require('chotsoad.php');



require('quangcaop.php');

echo '<div class="phdr">CHƠI XỔ SỐ VUI ĐUA TOP</div>';


if(isset($acc_id)){

echo '<div class="rmenu">Chơi Loto và ĐB Online là chơi vui cộng xu đua TOP để nhận quà từ Admin. Nghiêm cấm chơi lô đề Online</div>';
echo '
<div class="menusmall" style="background:#00BCD5">» <a href="/danh_lo_de/xoso.htm">Chơi ĐB vui online</a></div>
<div class="menusmall" style="background:#00BCD5">» <a href="/danh_lo_de/loto.htm">Chơi Loto vui online</a></div>
	
';
}
else
{
	echo'<div class="tme">
<center><p>
<strong style="color:#FF0000">
CHƠI XỔ SỐ VUI ĐUA TOP</strong> 
<br>
Hãy đăng ký thành viên để chơi xổ số vui đua top nhận thưởng thẻ cào

</p></center>

</div>';
echo '<div class="rmenu"> <a  href="/users/register.htm">Đăng Ký</a>  Xem Chuyên Gia Dự Đoán <a  href="/users/login.htm">Đăng Nhập</a> Soi Cầu Miễn Phí Hàng Ngày </div>';
}
//Khu vuc chot so vip
echo '<div class="phdr">KHU VỰC SỐ CHỐT PHÒNG VIP</div>';
if(isset($acc_id))
{
	echo '<div style="overflow:scroll;height:400px;" class="vip-section">';
	$gchat = mysql_query("SELECT * FROM `chat` WHERE `type`='chot' and `acc`='12925' ORDER BY `time` DESC LIMIT 60");
	$total=mysql_result(mysql_query("SELECT COUNT(id) FROM `chat` WHERE`type`='chot'"),0);

	if($total>0)
	{
		if(isset($admin) && ($acc_id==1))
		{
			echo '<div class="rmenu"><a href="/?empty=chot">Dọn dẹp chốt số</a></div>';
		}
		while ($chat = mysql_fetch_assoc($gchat))
 		{
			echo '
			'.(isset($_GET['reply']) && $_GET['reply']!=$chat['id'] ? 
			'<div style="opacity: 0.2;" class="menusmall" id="chat'.$chat['id'].'">' : 
			'<div class="menusmall" id="chat'.$chat['id'].'">').'
			'.nick($chat['acc'],$chat['time']).' <small>'.bbcode(smile($chat['text'])).'</small><br/>'; 


			if(empty($_GET['reply']))
			{
				$gcmt = mysql_query("SELECT * FROM `chat` WHERE `type`='cmt' AND `refid`='".$chat['id']."' ORDER BY `time` DESC LIMIT $kmess");
				while ($cmt = mysql_fetch_assoc($gcmt)) 
				{
					echo '<div class="replyBox" id="reply_content"><div class="detail_chem reply">'.menick($cmt['acc'],$cmt['time']).
					'<small> '.bbcode(smile($cmt['text'])).' </small> '.(isset($admin) ? ' - <a style="color:red" href="/?del='.$cmt['id']
					.'" onclick="return confirm('.$conf.');"><i class="fa fa-trash" aria-hidden="true"></i>Xóa
					</a>' : '').'</div></div>';
				}
			}


			$bl=mysql_result(mysql_query("SELECT COUNT(id) FROM `chat` WHERE`type`='cmt' AND `refid`='".$chat['id']."'"),0);
			if(isset($_GET['reply']) && $_GET['reply']==$chat['id'])
			{
				$gcmt = mysql_query("SELECT * FROM `chat` WHERE `type`='cmt' AND `refid`='".$chat['id']."' ORDER BY `time` DESC LIMIT 100");
				while ($cmt = mysql_fetch_assoc($gcmt)) 
				{
					echo '<div class="replyBox" id="reply_content"><div class="detail_chem reply">'.menick($cmt['acc'],$cmt['time'])
					.'<small> '.bbcode(smile($cmt['text'])).' </small> '.(isset($admin) ? ' - <a style="color:red" href="/?del='.$cmt['id']
					.'" onclick="return confirm('.$conf.');"><i class="fa fa-trash" aria-hidden="true"></i>Xóa
					</a>' : '').'</div></div>';
				}

				if(isset($_POST['submit']))
				{

					if(strlen($_POST['text']) > 20000 || strlen($_POST['text']) < 3)
					{
						echo '<script language="JavaScript1.1">	alert("• Nội dung phải nhiều hơn 3 ký tự và ít hơn 20000")</script>';
						echo '<script type="text/javascript">window.location.href = "/?reply='.$_GET['reply'].'&page='.$page.'"</script>';
	
						exit;
					}

					$query = "INSERT INTO `chat` SET
					`acc` = '$acc_id',
					`text` = '".strip_tags($_POST['text'])."',
					`time` = '" . time() . "',
					`type` = 'cmt',
					`refid` = '".$_GET['reply']."'";
					// die($query);
					mysql_query($query);
					mysql_query("UPDATE `account` SET `antispam`='" . (time()+20) . "' WHERE `id` = '".$acc_id."'");
	
					echo '<script type="text/javascript">
					window.location.href = "/?page='.$page.'#chat'.$_GET['reply'].'"
					</script>';
					exit;
				}
				echo '<form action="" method="post"/>
				<div class="menusmall"><textarea name="text"></textarea></div>
				
				<div class="menusmall"><input name="submit" type="submit" value="Đăng bình luận"/></div></form>
				';
			}
			if(isset($acc_id))
			{
				echo ' <br />'.($chat['acc']==$acc_id ? ' - <a style="color:blue" href="/?edit='.$chat['id'].'">Chỉnh Sửa</a> ' : '').' '
				.(isset($admin) ? ' - <a style="color:red" href="/?del='.$chat['id'].'" onclick="return confirm('.$conf.');"><i class="fa fa-trash" aria-hidden="true">
				</i>Xóa</a>' : '').''.(preg_match("#-".$acc_id."-#is", $chat['liked']) ? '<a href="?unlike='.$chat['id'].'">'
				.$chat['like'].' <i class="fa fa-thumbs-down" aria-hidden="true"></i></a>' : '<a href="?like='.$chat['id']
				.'">'.$chat['like'].' <i class="fa fa-thumbs-up" aria-hidden="true"></i></a>').'</div>';
			}
			echo '';
		}
	}
	else
	{
		echo '<div class="rmenu">Chưa có số đã chốt</div>';
	}
	echo '</div></div>';
}
else
{
	echo '<div class="rmenu"> <a  href="/sovip/dang-ky">Đăng Ký</a>  Để xem số Phòng Vip <a  href="/sovip/dang-nhap">Đăng Nhập</a> Để lấy số Phòng Vip </div><br>

	

';
}
//Khu vuc chot cho cua QTV	
echo '<div class="phdr" style="background:yellow;color:black">KHU VỰC QUẢN TRỊ VIÊN CHỐT SỐ</div>';
if(isset($acc_id))
{
	//echo '<div style="overflow:scroll;height:600px;">';
	$gchat = mysql_query("SELECT * FROM `chat` WHERE `type`='chot' and `acc`<>'12925' ORDER BY `time` DESC LIMIT $start_chotso, $khuchotso");
	$total=mysql_result(mysql_query("SELECT COUNT(id) FROM `chat` WHERE`type`='chot'"),0);

	if($total>0)
	{
	echo "<div class='chat-blue qtv-chot-so'>";

		if(isset($admin) && ($acc_id==1))
		{
			echo '<div class="rmenu"><a href="/?empty=chot">Dọn dẹp chốt số</a></div>';
		}
		while ($chat = mysql_fetch_assoc($gchat))
 		{
			echo '
			'.(isset($_GET['reply']) && $_GET['reply']!=$chat['id'] ? 
			'<div style="opacity: 0.2;" class="menusmall" id="chat'.$chat['id'].'">' : 
			'<div class="menusmall" id="chat'.$chat['id'].'">').'
			'.nick($chat['acc'],$chat['time']).' <small>'.bbcode(smile($chat['text'])).'</small><br/>'; 


			if(empty($_GET['reply']))
			{
				$gcmt = mysql_query("SELECT * FROM `chat` WHERE `type`='cmt' AND `refid`='".$chat['id']."' ORDER BY `time` DESC LIMIT $khuchotso");
				while ($cmt = mysql_fetch_assoc($gcmt)) 
				{
					echo '<div class="replyBox" id="reply_content"><div class="detail_chem reply">'.menick($cmt['acc'],$cmt['time']).
					'<small> '.bbcode(smile($cmt['text'])).' </small> '.(isset($admin) ? ' - <a style="color:red" href="/?del='.$cmt['id']
					.'" onclick="return confirm('.$conf.');"><i class="fa fa-trash" aria-hidden="true"></i>Xóa
					</a>' : '').'</div></div>';
				}
			}


			$bl=mysql_result(mysql_query("SELECT COUNT(id) FROM `chat` WHERE`type`='cmt' AND `refid`='".$chat['id']."'"),0);
			if(isset($_GET['reply']) && $_GET['reply']==$chat['id'])
			{
				$gcmt = mysql_query("SELECT * FROM `chat` WHERE `type`='cmt' AND `refid`='".$chat['id']."' ORDER BY `time` DESC LIMIT 100");
				while ($cmt = mysql_fetch_assoc($gcmt)) 
				{
					echo '<div class="replyBox" id="reply_content"><div class="detail_chem reply">'.menick($cmt['acc'],$cmt['time'])
					.'<small> '.bbcode(smile($cmt['text'])).' </small> '.(isset($admin) ? ' - <a style="color:red" href="/?del='.$cmt['id']
					.'" onclick="return confirm('.$conf.');"><i class="fa fa-trash" aria-hidden="true"></i>Xóa
					</a>' : '').'</div></div>';
				}

				if(isset($_POST['submit']))
				{

					if(strlen($_POST['text']) > 20000 || strlen($_POST['text']) < 3)
					{
						echo '<script language="JavaScript1.1">	alert("• Nội dung phải nhiều hơn 3 ký tự và ít hơn 20000")</script>';
						echo '<script type="text/javascript">window.location.href = "/?reply='.$_GET['reply'].'&page='.$page.'"</script>';
	
						exit;
					}

					$query = "INSERT INTO `chat` SET
					`acc` = '$acc_id',
					`text` = '".strip_tags($_POST['text'])."',
					`time` = '" . time() . "',
					`type` = 'cmt',
					`refid` = '".$_GET['reply']."'";
					// error_log( 'query:' . $query  , 3 , '/home/sctutsco/soicauchuantoilatoi.com/err.log' ); die;
					mysql_query($query);
					mysql_query("UPDATE `account` SET `antispam`='" . (time()+20) . "' WHERE `id` = '".$acc_id."'");
				
					echo '<script type="text/javascript">
					window.location.href = "/?page='.$page.'#chat'.$_GET['reply'].'"
					</script>';
					exit;
				}
				echo '<form action="" method="post"/>
				<div class="menusmall"><textarea name="text"></textarea></div>
				
				<div class="menusmall"><input name="submit" type="submit" value="Đăng bình luận"/></div></form>
				';
			}
			if(isset($acc_id))
			{
				echo ' <br />'.($chat['acc']==$acc_id ? ' - <a style="color:blue" href="/?edit='.$chat['id'].'">Chỉnh Sửa</a> ' : '').' '
				.(isset($admin) ? ' - <a style="color:red" href="/?del='.$chat['id'].'" onclick="return confirm('.$conf.');"><i class="fa fa-trash" aria-hidden="true">
				</i>Xóa</a>' : '').''.(preg_match("#-".$acc_id."-#is", $chat['liked']) ? '<a href="?unlike='.$chat['id'].'">'
				.$chat['like'].' <i class="fa fa-thumbs-down" aria-hidden="true"></i></a>' : '<a href="?like='.$chat['id']
				.'">'.$chat['like'].' <i class="fa fa-thumbs-up" aria-hidden="true"></i></a>').'</div>';
			}
			echo '';
		}
		echo "</div><!-- chat blue -->";
		if($total>$khuchotso){
			echo '<div style="text-align:center;padding:10px"><span class="classtrang">' . nextpage_chotso('?', $start_chotso, $total, $khuchotso, '4') . '</span></div>';
		}

	}
	else
	{
		echo '<div class="rmenu">Chưa có số đã chốt</div>';
	}
	echo '</div>';
}
else
{
	echo '<div class="rmenu"> <a  href="/users/register.htm">Đăng Ký</a>  Xem Chuyên Gia Dự Đoán <a  href="/users/login.htm">Đăng Nhập</a> Soi Cầu Miễn Phí Hàng Ngày </div><br>

	<div class="phdr">TIỆN ÍCH SOI CẦU</div>

	<div class="rmenu"> <a href="/users/register.htm">Đăng Ký</a>  Để xem công cụ phân tích<a href="/users/login.htm">Đăng Nhập</a> dự đoán kqxs đẹp hàng ngày</div>

';
}

/** khu cũ thong báo */
echo '<div class="phdr" style="font-size: 18px;">KHU THÔNG BÁO VÀ CHỐT SỐ HÀNG NGÀY CỦA BANG CHỦ AdminToilatoi</div>';
?>
<div id="banner__text">
	<div class="banner__images">
		<img src="/images/chotso.gif" title="banner">
	</div>
	
</div>
<?php
if(isset($_POST["delete"])){
      $id=$_POST["delete"];
      $sql="DELETE FROM block_message WHERE id='{$id}'";
      $query=mysql_query($sql);
      if($query){
            echo "<script>alert('Xóa thông báo thành công !!!');</script>";
        }else{
            echo "Xóa thông báo thất bại !!!" .mysqli_error($connect);
        }
}
if(isset($acc_id)){
      if($acc_id==1){
		$sql="SELECT * FROM block_message ORDER BY id DESC LIMIT $start_message,$message";
		$query=mysql_query($sql);
		$total=mysql_result(mysql_query("SELECT COUNT(id) FROM block_message"),0);
		$conf="Bạn có muốn xóa thông báo này không";
		if($total>0){
			while($row=mysql_fetch_assoc($query)){
				echo "<div class='menusmall' style='font-size: 20px !important;font-weight:400 !important;'><span>".bbcode(smile($row['content']))." </span><span><form method='post'><input type='hidden' value='".$row['id']."' name='delete'><button type='submit' name='btn-delete' style='background: transparent;border: none;color: #ff3333;' onclick='return confirm('".$conf."'); '><i class='fa fa-trash' aria-hidden='true'></i>Xóa</button></form></span></div>";
			}
			if ($total > $message) {
				echo '<div style="text-align:center;padding:10px"><span class="classtrang">' . nextpage_mess('?', $start_message, $total,$message, '4') . '</span></div>';
			}
		}else{
			echo '<div class="menusmall">Chưa có thông báo !!!</div>';
		}
	}else{
		$sql="SELECT * FROM block_message ORDER BY id DESC LIMIT $start_message,$message";
		$query=mysql_query($sql);
		$total=mysql_result(mysql_query("SELECT COUNT(id) FROM block_message "),0);
		$conf="Bạn có muốn xóa thông báo này không";
		if($total>0){
			while($row=mysql_fetch_assoc($query)){
				echo "<div class='menusmall' style='font-size: 20px !important;font-weight:400 !important;'><span>".bbcode(smile($row['content']))." </span></div>";
			}
			echo '<div style="text-align:center;padding:10px"><span class="classtrang">' . nextpage_mess('?', $start_message, $total,$message, '4') . '</span></div>';
			
		}else{
			echo '<div class="menusmall">Chưa có thông báo !!!</div>';
		}
	}
}
else
{
	echo '<div class="rmenu"> <a  href="/users/register.htm">Đăng Ký</a>  Xem Chuyên Gia Dự Đoán <a  href="/users/login.htm">Đăng Nhập</a> Soi Cầu Miễn Phí Hàng Ngày </div><br>

	<div class="phdr">TIỆN ÍCH SOI CẦU</div>

	<div class="rmenu"> <a href="/users/register.htm">Đăng Ký</a>  Để xem công cụ phân tích<a href="/users/login.htm">Đăng Nhập</a> dự đoán kqxs đẹp hàng ngày</div>

';
}
if(isset($acc_id)){

echo'
<div class="phdr">TIỆN ÍCH SOICAUCHUANTOILATOI</div>

<div class="menusmall"><img src="/images/hot.gif"/>&nbsp;<a href="/huongdansudung.htm" target="_blank">Hướng dẫn sử dụng diễn đàn</a>&nbsp;<img src="/images/hot.gif"/></div>

<div class="menusmall"><img src="/images/hot.gif"/>&nbsp;<a href="/forum/soi-cau-bac-nho-tong-hop-hay-nhat-1.html">Soi cầu thống kê bạc nhớ tổng hợp</a>&nbsp;<img src="/images/hot.gif"/></div>

<div class="menusmall"><img src="/adsquangcao/giphy.gif"/>&nbsp;<a href="/quidinhthuong.htm" target="_blank">Quy định thưởng cho thành viên chia sẻ</a>&nbsp;<img src="/adsquangcao/giphy.gif"/></div>

<div class="menusmall"><img src="/adsquangcao/giphy.gif"/>&nbsp;<a href="/caothuchotso.htm" target="_blank">Giải đấu thi chốt Độc thủ lô</a>&nbsp;<img src="/adsquangcao/giphy.gif"/></div>
';
}


	echo '<div class="panel panel-default"> 
		<div class="phdr">
			<b>KHU VỰC CHỐT SỐ TỔNG HỢP</b>
    	</div>';
		echo'<div class="tme">
<center><p>
<strong style="color:#FF0000">
KHU VỰC CÁC QUẢN TRỊ VIÊN CHỐT</strong> 
<br>
(Miền Trung - Miền Nam - Nuôi Khung)

</p></center>

</div>';
echo '<div style="padding:2px; max-height:200px; *height:200px; *position:relative; overflow:auto"> ';
		
		$totalt=mysql_result(mysql_query("SELECT COUNT(id) FROM `forum` WHERE `type`='topic' and `cate_small`='4629' and `acc`='1' "),0);
		$gtop = mysql_query("SELECT * FROM `forum` WHERE `type`='topic'  and `cate_small`='4629' and `acc`='1' ORDER BY `time` DESC LIMIT 31");
	//if (isset($admin))
	//if ($gio> 19)
	//{
		if($totalt!=0)
		{
			while ($top = mysql_fetch_assoc($gtop)) 
			{
				echo '<div class="panel-body"> 
     			<div class="row"> 
      			<div class="col-xs-12"> 
       				<ul class="demo2"> 
						<li class="news-item">
							<a title="Xem bài viết: '.$top['text'].'" href="/forum/'.$top['tid'].'.html">'.$top['text'].'</a>
							<small>» Bởi: '.miunick($top['acc']).' '.(empty($top['last']) ? '' : '»Bài cuối: '.miunick($top['last']).'').'</small>
						</li>
					</ul> 
      			</div> 
     			</div>  
				</div>';

			}
		}
	//}
		echo '</div> ';
//===các bài viết đề SEO===//
echo '<div class="panel panel-default"> 
		<div class="phdr">
			SOI CẦU LÔ TÔ - SOI CẦU XỔ SỐ
    	</div>';
		
echo '<div style="padding:2px; max-height:200px; *height:200px; *position:relative; overflow:auto"> ';
		
		$totalt=mysql_result(mysql_query("SELECT COUNT(id) FROM `forum` WHERE `type`='topic' and `cate_small`='5804' and `acc`='13899' "),0);
		$gtop = mysql_query("SELECT * FROM `forum` WHERE `type`='topic'  and `cate_small`='5804' and `acc`='13899' ORDER BY `time` DESC LIMIT 31");
	//if (isset($admin))
	//if ($gio> 19)
	//{
		if($totalt!=0)
		{
			while ($top = mysql_fetch_assoc($gtop)) 
			{
				echo '<div class="panel-body"> 
     			<div class="row"> 
      			<div class="col-xs-12"> 
       				<ul class="demo2"> 
						<li class="news-item">
							<a title="Xem bài viết: '.$top['text'].'" href="/forum/'.$top['tid'].'.html">'.$top['text'].'</a>
							<small>» Bởi: '.miunick($top['acc']).' '.(empty($top['last']) ? '' : '»Bài cuối: '.miunick($top['last']).'').'</small>
						</li>
					</ul> 
      			</div> 
     			</div>  
				</div>';

			}
		}
	//}
		echo '</div> ';
//=========================//




echo '<div itemscope itemtype = "http://schema.org/Movie" ></div>

<div class="phdr" id="chat">DIỄN ĐÀN THẢO LUẬN XỔ SỐ</div>';
echo' <div class="rmenu" >Diễn đàn là để giao lưu, kết bạn, thảo luận về xổ số trên tinh thần vui vẻ, hòa đồng, giúp đỡ lẫn nhau.</div>';






if(isset($acc_id) && !isset($_GET['reply'])){


echo '<div id="ketqua"></div>';


echo '<form action="/index.php" method="post" id="schat">


'.show_smile('schat','contents').'








<div class="menusmall"><center><textarea class="form-control" id="contents"  rows="5" name="contents" placeholder="Đăng bài thảo luận" value="" maxlength="50000000000000"/></textarea></center></div>';
if($acc_rank>0){
echo '<div class="menusmall">
<input type="checkbox" name="chot" value="ok" /> Quản Trị Viên check vào đây để chốt số<br>
</div>';}
echo '<div class="menu"><center> <input type="button" id="submit" value="Đăng bài"/> <span id="loading" style="display:none"><img src="/images/loading.gif" alt="Xin chờ..."/></span></center>
</div></form>
<div class="rmenu"><strong><center>xem nội dung mới bấm vào đăng bình luận không cần phải tải lại trang vẫn xem được bài chát mới ! </center></strong></div>
';


}

if(empty($acc_id)){echo '<div class="rmenu" style="color:blue"><center></center></div>';}else{
if($gio>17){
echo '<div class="menusmall" style="color:#ff00ff">Sau 18h hệ thống sẽ tạm ngừng, hãy chốt vào ngày mai nhé!</div>';
}else{
echo '
<div class="menusmall" id="chot"><center><a class="btn btn-warning" style="color:blue" title="Chốt số mà bạn kết hôm nay" href="#chot" onclick="chot();">Chốt số bạn thích ngay</a></center></div>
';}
}


echo '<div id="dulieu">';




$gchat = mysql_query("SELECT * FROM `chat` WHERE `type`='chat' ORDER BY `time` DESC LIMIT $start, $kmess");
$total=mysql_result(mysql_query("SELECT COUNT(id) FROM `chat` WHERE`type`='chat'"),0);
if($total>0){
if(isset($admin) && ($acc_id==1)){
echo '<div class="rmenu">Dọn chat: <a onclick="return confirm(\'Toàn bộ phòng chat sẽ được dọn dẹp\');" href="/?empty=chat">Toàn Bộ</a> | <a onclick="returnconfirm(\'Xóa các bài chat cũ hơn 30 ngày trước?\');" href="?empty=chat_30day">30 ngày Trước</a></div>';
}


while ($chat = mysql_fetch_assoc($gchat)) {
echo '
'.(isset($_GET['reply']) && $_GET['reply']!=$chat['id'] ? '<div style="opacity: 0.2;" class="menusmall" id="chat'.$chat['id'].'">' : '<div class="menusmall" id="chat'.$chat['id'].'">').'
'.nick($chat['acc'],$chat['time']).' <small>'.bbcode(smile($chat['text'])).'</small><br/><br/>'; 


if(empty($_GET['reply'])){
$gcmt = mysql_query("SELECT * FROM `chat` WHERE `type`='cmt' AND `refid`='".$chat['id']."' ORDER BY `time` DESC LIMIT $kmess");
while ($cmt = mysql_fetch_assoc($gcmt)) {
echo '<div class="replyBox" id="reply_content"><div class="detail_chem reply">'.menick($cmt['acc'],$cmt['time']).'<small>  '.bbcode(smile($cmt['text'])).' </small> '.(isset($admin) ? ' - <a style="color:red" href="/?del='.$cmt['id'].'" onclick="return confirm('.$conf.');"><i class="fa fa-trash" aria-hidden="true"></i>Xóa
</a>' : '').'</div></div></li></ul>';
}
}


$bl=mysql_result(mysql_query("SELECT COUNT(id) FROM `chat` WHERE`type`='cmt' AND `refid`='".$chat['id']."'"),0);
if(isset($_GET['reply']) && $_GET['reply']==$chat['id']){
$gcmt = mysql_query("SELECT * FROM `chat` WHERE `type`='cmt' AND `refid`='".$chat['id']."' ORDER BY `time` DESC LIMIT 100");
while ($cmt = mysql_fetch_assoc($gcmt)) {
echo '<div class="replyBox" id="reply_content"><div class="detail_chem reply">'.menick($cmt['acc'],$cmt['time']).'<small> '.bbcode(smile($cmt['text'])).' </small> '.(isset($admin) ? ' - <a style="color:red" href="/?del='.$cmt['id'].'" onclick="return confirm('.$conf.');"><i class="fa fa-trash" aria-hidden="true"></i>Xóa
</a>' : '').'</div></div></li></ul>';
}




if(isset($_POST['submit'])){

if(strlen($_POST['text']) > 2000 || strlen($_POST['text']) < 3){
echo '<script language="JavaScript1.1">
alert("• Nội dung phải nhiều hơn 3 ký tự và ít hơn 2000")
</script>';
echo '<script type="text/javascript">
window.location.href = "/?reply='.$_GET['reply'].'&page='.$page.'"
</script>';

exit;
}


  $query = "INSERT INTO `chat` SET
            `acc` = '$acc_id',
            `text` = '".strip_tags($_POST['text'])."',
            `time` = '" . time() . "',
            `type` = 'cmt',
            `refid` = '".$_GET['reply']."'
        ";


  mysql_query($query);
  mysql_query("UPDATE `account` SET `antispam`='" . (time()+20) . "' WHERE `id` = '".$acc_id."'");

echo '<script type="text/javascript">
window.location.href = "/?page='.$page.'#chat'.$_GET['reply'].'"
</script>';
exit;
}





echo '<form action="" method="post" id="cmt"/>
'.show_smile('cmt','text').'
<div class="menusmall"><textarea id="text" name="text"></textarea></div>

<div class="menusmall"><input name="submit" type="submit" value="Gửi bình luận"/></div></form>
';
}


if(isset($acc_id)){
echo '<div class="amenu" style="font-size:small">'.(isset($_GET['reply']) && $_GET['reply']==$chat['id'] ? 'Có '.$bl.' bình luận' : '<a href="?reply='.$chat['id'].'&page='.$page.'#chat'.$chat['id'].'">Bình luận ('.$bl.')</a>').'
'.($chat['acc']==$acc_id ? ' ' : '').' '.(isset($admin) ? ' - <a style="color:red" href="/?del='.$chat['id'].'" onclick="return confirm('.$conf.');"><i class="fa fa-trash" aria-hidden="true"></i>Xóa
</a>' : '').'


<span style="float:right">
'.(preg_match("#-".$acc_id."-#is", $chat['liked']) ? '<a href="?unlike='.$chat['id'].'">'.$chat['like'].' <i class="fa fa-thumbs-down" aria-hidden="true"></i></a>' : '<a href="?like='.$chat['id'].'">'.$chat['like'].' <i class="fa fa-thumbs-up" aria-hidden="true"></i></a>').'
</div>';
}
echo '</div>';
}


 if ($total > $kmess) {
                    echo '<div style="text-align:center;padding:10px"><span class="classtrang">' . nextpage('?', $start, $total, $kmess, '4') . '</span></div>';
                }
}else{echo '<div class="rmenu">Chưa có bài chat nào</div>';}

echo '</div>';

// Nuôi khung vip
echo '<div class="panel panel-default"> 
		<div class="phdr">
			<b>KINH NGHIỆM DỰ ĐOÁN SOI CẦU XỔ SỐ</b>
    	</div>';
		echo'<div class="tme">

<p>
<strong style="color:#FF0000">
SOI CẦU XỔ SỐ</strong> 
</p>
Có nhiều bạn mới chơi lô đề hoặc được nghe nhiều người nhắc tới: soi cầu lô, soi cầu đề. Mà không hiểu soi cầu là gì. Thì hôm nay SoicauchuanToilatoi.com sẽ tìm hiểu và xin giải thích chi tiết tới các bạn định nghĩa soi cầu lô là gì, các vị trí cầu lô, Tổng số cầu lô cần soi sét. Và các phương pháp soi cầu lô, bí kíp soi cầu đề phổ biến hiện nay được rất nhiều bạn sử dụng.


</div>';
//echo '<div style="padding:2px; max-height:200px; *height:200px; *position:relative; overflow:auto"> ';

		
		$totalt=mysql_result(mysql_query("SELECT COUNT(id) FROM `forum` WHERE `type`='topic' and `cate_small`='5804' and `acc`='1' "),0);
		$gtop = mysql_query("SELECT * FROM `forum` WHERE `type`='topic'  and `cate_small`='5804' and `acc`='1' ORDER BY `time` DESC LIMIT 31");
	//if (isset($admin))
	//if ($gio> 19)
	//{
		if($totalt!=0)
		{
			while ($top = mysql_fetch_assoc($gtop)) 
			{
				echo '<div class="panel-body"> 
     			<div class="row"> 
      			<div class="col-xs-12"> 
       				<ul class="demo2"> 
						<li class="news-item">
							<a title="Xem bài viết: '.$top['text'].'" href="/forum/'.$top['tid'].'.html">'.$top['text'].'</a>
							<small>» Bởi: '.miunick($top['acc']).' '.(empty($top['last']) ? '' : '»Bài cuối: '.miunick($top['last']).'').'</small>
						</li>
					</ul> 
      			</div> 
     			</div>  
				</div>';

			}
		}
	//}
		//echo '</div> ';
//===========================


echo '<div class="phdr">BẢNG CHỐT THÀNH VIÊN <i>'.$dateday.'</i></div><div style="padding:2px; max-height:300px; *height:300px; *position:relative; overflow:auto"> ';

echo '<center><form id="search" class="tme" action="" method="GET"/><select onchange="location.href=this.options[this.selectedIndex].value">

<option value="#">Chọn ngày</option>
';
    for( $i= 1 ; $i <= 10 ; $i++ )
{

echo '<option value="/chotso/?day='.date('d-m-Y',time()+$muig-3600*24*$i).'">'.date('d-m-Y',time()+$muig-3600*24*$i).'</option>';

}

echo '</select></form></center>';


$gtag = mysql_query("SELECT * FROM `chotso` WHERE `key`='acc_chot' AND `date`='$datekq' ORDER BY `id` DESC LIMIT 100");
if(mysql_num_rows($gtag)!=0){
while ($tag = mysql_fetch_assoc($gtag)) {
echo '<div class="chot">'.$tag['value'].'</div>';}
}

echo '</div>';


function get_val_chot($key,$type,$value=''){
global $datekq;
$gtag = mysql_query("SELECT * FROM `chotso` WHERE `key`='".$key."'  AND `date`='$datekq'".(empty($value) ? "" : " AND `value`='".$value."'")."");
if(mysql_num_rows($gtag)!=0){
while ($tag = mysql_fetch_assoc($gtag)) {
if($type=='count' && $tag[''.$type.'']=="0"){return '*';}else{
return '<span style="color:red">'.$tag[''.$type.''].'</span>';}

}

}else{return '*';}

}


function get_val_chot_user($user,$key){
global $datekq;
$gtag = mysql_query("SELECT * FROM `chotso` WHERE `acc` LIKE '%-".$user."-%' AND `key`='$key' AND `date`='".$datekq."'");
if(mysql_num_rows($gtag)!=0){
while ($tag = mysql_fetch_assoc($gtag)) {
return $tag['value'];

}

}

}



echo '
<div class="phdr">ĐẶC BIỆT VÀ LOTO CHỐT NHIỀU <i>'.$dateday.'</i></div>
<table width="100%" id="chotso_data">
<tr><td class="rmenu"><center>ĐẶC BIỆT</center></td> <td class="rmenu"><center>LÔ TÔ</center></td> </tr>';

    for( $i= 1 ; $i <= 5 ; $i++ )
{

if(get_val_chot('result_xs_bachthu_'.$i.'','count')=="*" && get_val_chot('result_lo_bachthu_'.$i.'','count')=="*"){}else{

echo '<tr>
<td class="menu"><center>'.get_val_chot('result_xs_bachthu_'.$i.'','value').' <span style="font-size:11px" title="Lượt chốt"></span></center></td>

<td class="menu"><center>'.get_val_chot('result_lo_bachthu_'.$i.'','value').' <span style="font-size:11px" title="Lượt chốt"></span></center></td>

</tr>';
}

}

echo '</table>';













echo ''.alert('Chốt số kết. Chúc bạn may mắn!','<div class="rmenu">Hôm nay '.$dateday.', Chú ý chốt số cách nhau dấu phẩy ","</div>
<form id="chots" action="" method="POST"/>
<table width="100%">


<tr>
<td class="tme" width="5%"><center>*</center></td> 
<td class="tme" width="10%"><center>Cặp số</center></td> 
<td class="tme" width="8%" style="display:none"><center>Đầu</center></td> 
<td class="tme" width="8%" style="display:none"><center>Đuôi</center></td> 
<td class="tme" width="10%"><center>Bạch thủ</center></td>
</tr>

<tr>
<td class="rmenu" width="5%" title="Xổ Số Đặc Biệt"><center>ĐB</center></td> 
<td class="menu" width="10%"><center><input size="10" title="Cặp Số Bạn Kết" name="chotso[xs_cap]" type="text" placeholder="Cặp" value="'.get_val_chot_user(''.(empty($acc_id) ? '' : $acc_id).'','xs_cap').'"/></center></td> 
<td class="menu" width="8%" style="display:none"><center><input size="1" title="Đầu Số Bạn Kết" name="chotso[xs_dau]" type="text" placeholder="Đầu" value="'.get_val_chot_user(''.(empty($acc_id) ? '' : $acc_id).'','xs_dau').'"/></center></td> 
<td class="menu" width="8%" style="display:none"><center><input size="1" title="Đuôi Số Bạn Kết" name="chotso[xs_duoi]" type="text" placeholder="Đít" value="'.get_val_chot_user(''.(empty($acc_id) ? '' : $acc_id).'','xs_duoi').'"/></center></td> 
<td class="menu" width="10%"><center><input size="1" title="Bạch thủ" name="chotso[xs_bachthu]" type="text" placeholder="BT"
value="'.get_val_chot_user(''.(empty($acc_id) ? '' : $acc_id).'','xs_bachthu').'"/></center></td>
</tr>


<tr>
<td class="rmenu" width="5%" title="Lô Tô"><center>Lô</center></td>
<td class="menu" width="10%"><center><input size="10" title="Cặp Lô Bạn Kết" name="chotso[lo_cap]" type="text" placeholder="Cặp" value="'.get_val_chot_user(''.(empty($acc_id) ? '' : $acc_id).'','lo_cap').'"/></center></td> 
<td class="menu" width="8%" style="display:none"><center><input size="1" title="Đầu Lô Bạn Kết" name="chotso[lo_dau]" type="text" placeholder="Đầu" value="'.get_val_chot_user(''.(empty($acc_id) ? '' : $acc_id).'','lo_dau').'"/></center></td>
<td class="menu" width="8%" style="display:none"><center><input size="1" title="Đuôi Lô Bạn Kết" name="chotso[lo_duoi]" type="text" placeholder="Đít" value="'.get_val_chot_user(''.(empty($acc_id) ? '' : $acc_id).'','lo_duoi').'"/></center></td> 
<td class="menu" width="10%"><center><input size="1" title="Bạch thủ" name="chotso[lo_bachthu]" type="text" placeholder="BT" value="'.get_val_chot_user(''.(empty($acc_id) ? '' : $acc_id).'','lo_bachthu').'"/></center></td>
</tr>


</table>

<div id="kqchotso"></div>
<center class="tme"><div id="loading_chot" style="display:none">Đang chốt,Xin chờ...</div><input id="submit_chot" type="submit" value="Chốt số ngay"/>
</center>
</form>
','chot','500px'.(isset($mobile) ? ';width:100%' : '').'','').'';

if(empty($acc_id)){echo '<div class="rmenu" style="color:blue"><center>Vui lòng đăng nhập để chốt số</center></div>';}else{
if($gio>18){
echo '<div class="menusmall" style="color:#ff00ff">Sau 18h đóng bát chốt số ở bảng thành viên!!</div>';
}else{
echo '
<div class="menusmall" id="chot"><center><a class="btn btn-warning" style="color:blue" title="Chốt số mà bạn kết hôm nay" href="#chot" onclick="chot();">Chốt số bạn thích ngay</a></center></div>
';}
}


// top chot so
$gtop = mysql_query("SELECT * FROM `account` WHERE `chot_chuan_count`!='0' ORDER BY `chot_chuan_count` DESC LIMIT 10");

if(mysql_num_rows($gtop)!=0){
echo '<div class="phdr">TOP CAO THỦ SOI CẦU CHUẨN </div>
<table width="100%"><tr><td class="rmenu">Tên Cao Thủ</td> <td class="rmenu">Xổ Số</td> <td class="rmenu">Lô Tô</td> <td class="rmenu">Trình Độ</td> </tr>
';
while ($top = mysql_fetch_assoc($gtop)) {
echo '
<tr>
<td class="menu">'.maunick($top['id']).'</td>
<td class="menu">[<font color="red">'.($top['chot_chuan_xs'] > 0 && $top['chot_tong_xs'] > 0 ? round($top['chot_chuan_xs']/$top['chot_tong_xs']*100) : '0').'%</font>] '.$top['chot_chuan_xs'].' Lần chuẩn / '.$top['chot_tong_xs'].'</td>

<td class="menu">[<font color="red">'.($top['chot_chuan_lo'] > 0 && $top['chot_tong_lo'] > 0 ? round($top['chot_chuan_lo']/$top['chot_tong_lo']*100) : '0').'%</font>] '.$top['chot_chuan_lo'].' Lần chuẩn / '.$top['chot_tong_lo'].'</td>

<td class="menu">'.($top['chot_chuan_lo']>$top['chot_chuan_xs'] ? 'Cao thủ Lô' : 'Cao Thủ Đề').'</td> 

</tr>
';}
echo '</table>';
}



// Top dai gia
$gtop = mysql_query("SELECT * FROM `account` WHERE `money` != '0' ORDER BY `money` DESC LIMIT 10"); //10
if(mysql_num_rows($gtop)!=0){
echo '<div class="panel panel-default"> <div class="phdr"> <b>TOP 10 ĐẠI GIA SOI CẦU CHUẨN  </b></div><div style="height:155px; overflow:auto; *position:relative"><table class="table table-bordered soicau-table" width="100%">';
echo '<tr><td width="20%">TOP</td> <td class="name" width="40%">Đại Gia</td> <td class="balance" width="40%">Tài sản</td></tr>';
$i='0';
while ($top = mysql_fetch_assoc($gtop)) {
$i=$i+1;
echo '<tr><td width="20%">'.$i.'</td> <td class="name" width="40%">'.menick($top['id']).'</td> <td class="balance" width="40%">'.money($top['money']).' <i class="fa fa-money" aria-hidden="true"></i>
</td></tr>';}
echo '</table></div></div>';
}
// end top dai gia



// top like

$gtop = mysql_query("SELECT * FROM `account` ORDER BY `liked` DESC LIMIT 6");
echo '<div class="phdr">TOP CAO THỦ ĐƯỢC YÊU THÍCH NHẤT</div>';
if(mysql_num_rows($gtop)!=0){

while ($top = mysql_fetch_assoc($gtop)) {
echo '<div class="menusmall">'.miunick($top['id']).'<span style="float:right">'.$top['liked'].' <i class="fa fa-diamond" aria-hidden="true"></i>

</span></div>';}

}

//echo'<div class="phdr"> KẾT QUẢ TƯỜNG THUẬT TRỰC TIẾP XỔ SỐ MIỀN BẮC</div>';
//require_once('tructiep.php');
//-----------------

	$gkq = mysql_query("SELECT * FROM `result` WHERE `key`='truyenthong' order by `id` desc limit 1");
	if(mysql_num_rows($gkq)!=0)
	{
		
		while ($kq = mysql_fetch_assoc($gkq)) 
		{
			echo '<div class="phdr">KẾT QUẢ XỔ SỐ MIỀN BẮC NGÀY '.$kq['date'].'</div>';
			echo $kq['value'];
		}
	}
	else
	{
		echo '<div class="rmenu">Kết quả của ngày này đã không tồn tại</div>';
	}
	
	//---------------
		$gkq = mysql_query("SELECT * FROM `result` WHERE `key`='loto' order by `id` desc limit 1");
	if(mysql_num_rows($gkq)!=0)
	{
		
		while ($kq = mysql_fetch_assoc($gkq)) 
		{
		
			echo $kq['value'];
		}
	}
	else
	{
		echo '<div class="rmenu">Kết quả của ngày này đã không tồn tại</div>';
	}
	//---------------
		$gkq = mysql_query("SELECT * FROM `result` WHERE `key`='thantai' order by `id` desc limit 1");
	if(mysql_num_rows($gkq)!=0)
	{
		
		while ($kq = mysql_fetch_assoc($gkq)) 
		{
		
			echo $kq['value'];
		}
	}
	else
	{
		echo '<div class="rmenu">Kết quả của ngày này đã không tồn tại</div>';
	}

//-----------------

echo'<div class="phdr">THỐNG KÊ HỆ THỐNG</div>';

 $req = mysql_query("SELECT * FROM `account` ORDER BY `regdate` DESC LIMIT 1");
while (($res = mysql_fetch_array($req)) !== false) {
echo '<div class="rmenu"><i class="fa fa-id-card-o" aria-hidden="true"></i>
 Chào đón thành viên mới gia nhập: '.miunick($res['id']).'</div>';

       }

$reqb = mysql_query("SELECT * FROM `account`");
$total = mysql_num_rows($reqb);
echo '<div class="rmenu"><i class="fa fa-area-chart" aria-hidden="true"></i>
 Tổng số thành viên đã đăng kí  '.$total.' thành viên </div>';

if(isset($acc_id)){

$req = mysql_query("SELECT * FROM `account` WHERE `lastonline` > '".(time()-520)."'  ORDER BY `lastonline` DESC LIMIT 150");
$tton=mysql_result(mysql_query("SELECT COUNT(*) FROM `account` WHERE `lastonline` > '".(time()-520)."'"),0);

echo '<div class="rmenu"><i class="fa fa-user" aria-hidden="true"></i> Thành Viên Trực Tuyến </div><div class="rmenu">
';
while (($res = mysql_fetch_array($req)) !== false) {

echo ''.miunick($res['id']).',';
       }
}
echo'</div>';

require('incfiles/footer.php');