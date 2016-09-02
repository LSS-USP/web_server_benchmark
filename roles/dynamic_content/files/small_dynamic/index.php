<?php

 define('MAX_LEN', 23 * 1024);
 define('HASH_LEN', 32); // size returned from md5

 /* # of hashes */
 $num_hashes = MAX_LEN / 32;

 $data = "";
 for($i = 0; $i < $num_hashes; $i++)
   $data .= md5(mt_rand());

 echo $data;
?>
