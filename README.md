# mediawiki
https://www.mediawiki.org/wiki/MediaWiki-Docker/zh

https://www.semantic-mediawiki.org/wiki/Help:Installation/zh-hans

https://github.com/SemanticMediaWiki/Mermaid


<pre>


/var/lib/postgresql/18/docker/postgresql.conf

shared_preload_libraries = 'pg_stat_statements'
pg_stat_statements.track = all

/var/lib/postgresql/data


</pre>
 <img src="./wiki.png"/>

# shawoo/semantic-media-wiki
<pre>
#在 LocalSettings.php 末尾追加两行（顺序不能反）：
wfLoadExtension( 'SemanticMediaWiki' );
enableSemantics( 'http://wiki.feg.cn' );   // 与 $wgServer 保持一致
# 屏蔽所有 E_USER_DEPRECATED
error_reporting( E_ALL & ~E_USER_DEPRECATED );
ini_set( 'display_errors', 0 );

# root bash
docker exec -it -u root mediawiki-mediawiki-1 bash 
php maintenance/update.php --quick
</pre>
