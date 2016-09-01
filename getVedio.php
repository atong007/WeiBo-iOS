<?php
    $url = $_GET['url'];
//    $url ="http://video.weibo.com/show?fid=1034:d20ce32dec9ab688ae92b831c514e0a1";
    sina($url);
    function sina($url){   //微博视频解析
        $data = file_get_contents($url);
        preg_match('|flashvars="list=(.*)" />|',$data,$a);
        echo urldecode($a[1]);
    }
?>