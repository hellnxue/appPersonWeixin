<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">所在城市</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<!-- 地图，获取定位城市用 -->
<div class="maps" id="allmap"></div>
<form action="${ctx }/webApp/user/city" method="post" id="form1">
  <input type="hidden" name="ccity" id="ccity"/>

</form>
<div class="city_list"> 
  <div class="city-wrapper" id="city-wrapper">
   <div style="display:none" id="pcy">
   <h3 class="cityhli city-key-rm">定位城市</h3>
   <ul><li id="positionCity" onclick="javascript:$(this).prop('class','cur');$('#ccity').val($(this).text());$('#form1').submit();"></li></ul> 
   </div>
    <h3 class="cityhli city-key-rm">热门城市</h3>
    <ul>
      <li data-name="北京" data-id="53">北京</li>
      <li data-name="上海" data-id="321">上海</li>
      <li data-name="重庆" data-id="394">重庆</li>
      <li data-name="深圳" data-id="91">深圳</li>
    </ul>
    <h3 class="cityhli city-key-A">A</h3>
    <ul>
      <li data-name="安庆" data-id="36">安庆</li>
      <li data-name="安阳" data-id="150">安阳</li>
      <li data-name="阿坝" data-id="322">阿坝</li>
      <li data-name="鞍山" data-id="245">鞍山</li>
      <li data-name="安顺" data-id="112">安顺</li>
      <li data-name="安康" data-id="311">安康</li>
      <li data-name="阿克苏" data-id="351">阿克苏</li>
      <li data-name="阿勒泰" data-id="3114">阿勒泰</li>
    </ul>
    <h3 class="cityhli city-key-B">B</h3>
    <ul>
      <li data-name="北京" data-id="53">北京</li>
      <li data-name="北海" data-id="99">北海</li>
      <li data-name="包头" data-id="261">包头</li>
      <li data-name="保定" data-id="139">保定</li>
      <li data-name="蚌埠" data-id="37">蚌埠</li>
      <li data-name="滨州" data-id="283">滨州</li>
      <li data-name="宝鸡" data-id="312">宝鸡</li>
      <li data-name="保山" data-id="367">保山</li>
      <li data-name="亳州" data-id="52">亳州</li>
      <li data-name="百色" data-id="98">百色</li>
      <li data-name="白山" data-id="213">白山</li>
      <li data-name="本溪" data-id="246">本溪</li>
      <li data-name="巴音郭楞" data-id="353">巴音郭楞</li>
      <li data-name="巴彦淖尔" data-id="260">巴彦淖尔</li>
      <li data-name="巴中" data-id="323">巴中</li>
      <li data-name="保亭" data-id="122">保亭</li>
      <li data-name="毕节" data-id="113">毕节</li>
      <li data-name="白银" data-id="63">白银</li>
    </ul>
    <h3 class="cityhli city-key-C">C</h3>
    <ul>
      <li data-name="成都" data-id="324">成都</li>
      <li data-name="长沙" data-id="199">长沙</li>
      <li data-name="重庆" data-id="394">重庆</li>
      <li data-name="常州" data-id="221">常州</li>
      <li data-name="长春" data-id="214">长春</li>
      <li data-name="长白山" data-id="4569">长白山</li>
      <li data-name="池州" data-id="39">池州</li>
      <li data-name="承德" data-id="141">承德</li>
      <li data-name="常德" data-id="198">常德</li>
      <li data-name="郴州" data-id="200">郴州</li>
      <li data-name="长治" data-id="300">长治</li>
      <li data-name="沧州" data-id="140">沧州</li>
      <li data-name="滁州" data-id="40">滁州</li>
      <li data-name="巢湖" data-id="38">巢湖</li>
      <li data-name="潮州" data-id="77">潮州</li>
      <li data-name="崇左" data-id="100">崇左</li>
      <li data-name="楚雄" data-id="368">楚雄</li>
      <li data-name="赤峰" data-id="262">赤峰</li>
      <li data-name="朝阳" data-id="247">朝阳</li>
      <li data-name="昌吉" data-id="355">昌吉</li>
      <li data-name="昌都" data-id="345">昌都</li>
      <li data-name="昌江" data-id="123">昌江</li>
      <li data-name="澄迈" data-id="124">澄迈</li>
    </ul>
    <h3 class="cityhli city-key-D">D</h3>
    <ul>
      <li data-name="大连" data-id="248">大连</li>
      <li data-name="东莞" data-id="78">东莞</li>
      <li data-name="大理" data-id="369">大理</li>
      <li data-name="大同" data-id="301">大同</li>
      <li data-name="丹东" data-id="249">丹东</li>
      <li data-name="东营" data-id="285">东营</li>
      <li data-name="德阳" data-id="326">德阳</li>
      <li data-name="大庆" data-id="168">大庆</li>
      <li data-name="迪庆" data-id="371">迪庆</li>
      <li data-name="德州" data-id="284">德州</li>
      <li data-name="儋州" data-id="138">儋州</li>
      <li data-name="德宏" data-id="370">德宏</li>
      <li data-name="大兴安岭" data-id="169">大兴安岭</li>
      <li data-name="定安" data-id="125">定安</li>
      <li data-name="达州" data-id="325">达州</li>
    </ul>
    <h3 class="cityhli city-key-E">E</h3>
    <ul>
      <li data-name="鄂尔多斯" data-id="263">鄂尔多斯</li>
      <li data-name="恩施" data-id="182">恩施</li>
      <li data-name="鄂州" data-id="181">鄂州</li>
    </ul>
    <h3 class="cityhli city-key-F">F</h3>
    <ul>
      <li data-name="福州" data-id="54">福州</li>
      <li data-name="佛山" data-id="79">佛山</li>
      <li data-name="阜阳" data-id="41">阜阳</li>
      <li data-name="防城港" data-id="101">防城港</li>
      <li data-name="抚顺" data-id="250">抚顺</li>
      <li data-name="抚州" data-id="234">抚州</li>
    </ul>
    <h3 class="cityhli city-key-G">G</h3>
    <ul>
      <li data-name="广州" data-id="80">广州</li>
      <li data-name="桂林" data-id="102">桂林</li>
      <li data-name="贵阳" data-id="114">贵阳</li>
      <li data-name="赣州" data-id="235">赣州</li>
      <li data-name="甘孜" data-id="327">甘孜</li>
      <li data-name="广元" data-id="329">广元</li>
      <li data-name="广安" data-id="328">广安</li>
      <li data-name="贵港" data-id="103">贵港</li>
      <li data-name="固原" data-id="271">固原</li>
    </ul>
    <h3 class="cityhli city-key-H">H</h3>
    <ul>
      <li data-name="杭州" data-id="383">杭州</li>
      <li data-name="香港" data-id="35">香港</li>
      <li data-name="哈尔滨" data-id="170">哈尔滨</li>
      <li data-name="合肥" data-id="42">合肥</li>
      <li data-name="黄山" data-id="45">黄山</li>
      <li data-name="海口" data-id="127">海口</li>
      <li data-name="呼和浩特" data-id="264">呼和浩特</li>
      <li data-name="淮安" data-id="222">淮安</li>
      <li data-name="惠州" data-id="82">惠州</li>
      <li data-name="湖州" data-id="384">湖州</li>
      <li data-name="呼伦贝尔" data-id="265">呼伦贝尔</li>
      <li data-name="衡阳" data-id="201">衡阳</li>
      <li data-name="菏泽" data-id="286">菏泽</li>
      <li data-name="邯郸" data-id="142">邯郸</li>
      <li data-name="河源" data-id="81">河源</li>
      <li data-name="汉中" data-id="313">汉中</li>
      <li data-name="怀化" data-id="202">怀化</li>
      <li data-name="葫芦岛" data-id="252">葫芦岛</li>
      <li data-name="衡水" data-id="143">衡水</li>
      <li data-name="淮南" data-id="44">淮南</li>
      <li data-name="黄石" data-id="184">黄石</li>
      <li data-name="黄冈" data-id="183">黄冈</li>
      <li data-name="海西" data-id="279">海西</li>
      <li data-name="鹤岗" data-id="171">鹤岗</li>
      <li data-name="黑河" data-id="172">黑河</li>
      <li data-name="河池" data-id="104">河池</li>
      <li data-name="淮北" data-id="43">淮北</li>
      <li data-name="贺州" data-id="105">贺州</li>
      <li data-name="鹤壁" data-id="151">鹤壁</li>
      <li data-name="和田" data-id="357">和田</li>
      <li data-name="海南藏族" data-id="278">海南藏族</li>
      <li data-name="红河" data-id="372">红河</li>
    </ul>
    <h3 class="cityhli city-key-J">J</h3>
    <ul>
      <li data-name="济南" data-id="287">济南</li>
      <li data-name="嘉兴" data-id="385">嘉兴</li>
      <li data-name="金华" data-id="386">金华</li>
      <li data-name="九江" data-id="238">九江</li>
      <li data-name="晋中" data-id="303">晋中</li>
      <li data-name="济宁" data-id="288">济宁</li>
      <li data-name="江门" data-id="83">江门</li>
      <li data-name="吉安" data-id="236">吉安</li>
      <li data-name="吉林" data-id="215">吉林</li>
      <li data-name="酒泉" data-id="68">酒泉</li>
      <li data-name="景德镇" data-id="237">景德镇</li>
      <li data-name="荆州" data-id="186">荆州</li>
      <li data-name="焦作" data-id="153">焦作</li>
      <li data-name="晋城" data-id="302">晋城</li>
      <li data-name="锦州" data-id="253">锦州</li>
      <li data-name="嘉峪关" data-id="66">嘉峪关</li>
      <li data-name="揭阳" data-id="84">揭阳</li>
      <li data-name="荆门" data-id="185">荆门</li>
      <li data-name="济源" data-id="152">济源</li>
      <li data-name="鸡西" data-id="173">鸡西</li>
      <li data-name="佳木斯" data-id="174">佳木斯</li>
      <li data-name="金昌" data-id="67">金昌</li>
    </ul>
    <h3 class="cityhli city-key-K">K</h3>
    <ul>
      <li data-name="昆明" data-id="373">昆明</li>
      <li data-name="开封" data-id="154">开封</li>
      <li data-name="喀什" data-id="358">喀什</li>
      <li data-name="克拉玛依" data-id="359">克拉玛依</li>
    </ul>
    <h3 class="cityhli city-key-L">L</h3>
    <ul>
      <li data-name="丽江" data-id="374">丽江</li>
      <li data-name="洛阳" data-id="155">洛阳</li>
      <li data-name="乐山" data-id="330">乐山</li>
      <li data-name="连云港" data-id="223">连云港</li>
      <li data-name="拉萨" data-id="346">拉萨</li>
      <li data-name="兰州" data-id="69">兰州</li>
      <li data-name="临沂" data-id="291">临沂</li>
      <li data-name="丽水" data-id="387">丽水</li>
      <li data-name="廊坊" data-id="144">廊坊</li>
      <li data-name="聊城" data-id="290">聊城</li>
      <li data-name="六安" data-id="46">六安</li>
      <li data-name="莱芜" data-id="289">莱芜</li>
      <li data-name="凉山" data-id="331">凉山</li>
      <li data-name="柳州" data-id="107">柳州</li>
      <li data-name="龙岩" data-id="55">龙岩</li>
      <li data-name="漯河" data-id="166">漯河</li>
      <li data-name="临汾" data-id="304">临汾</li>
      <li data-name="娄底" data-id="203">娄底</li>
      <li data-name="陵水" data-id="130">陵水</li>
      <li data-name="林芝" data-id="347">林芝</li>
      <li data-name="泸州" data-id="342">泸州</li>
      <li data-name="六盘水" data-id="115">六盘水</li>
      <li data-name="来宾" data-id="106">来宾</li>
      <li data-name="辽源" data-id="216">辽源</li>
      <li data-name="辽阳" data-id="254">辽阳</li>
      <li data-name="吕梁" data-id="305">吕梁</li>
    </ul>
    <h3 class="cityhli city-key-M">M</h3>
    <ul>
      <li data-name="澳门" data-id="35">澳门</li>
      <li data-name="绵阳" data-id="333">绵阳</li>
      <li data-name="牡丹江" data-id="175">牡丹江</li>
      <li data-name="马鞍山" data-id="47">马鞍山</li>
      <li data-name="梅州" data-id="86">梅州</li>
      <li data-name="茂名" data-id="85">茂名</li>
      <li data-name="眉山" data-id="332">眉山</li>
    </ul>
    <h3 class="cityhli city-key-N">N</h3>
    <ul>
      <li data-name="南京" data-id="224">南京</li>
      <li data-name="宁波" data-id="388">宁波</li>
      <li data-name="南昌" data-id="239">南昌</li>
      <li data-name="南宁" data-id="108">南宁</li>
      <li data-name="南通" data-id="225">南通</li>
      <li data-name="南平" data-id="56">南平</li>
      <li data-name="宁德" data-id="57">宁德</li>
      <li data-name="南充" data-id="334">南充</li>
      <li data-name="南阳" data-id="156">南阳</li>
      <li data-name="内江" data-id="335">内江</li>
      <li data-name="怒江" data-id="376">怒江</li>
    </ul>
    <h3 class="cityhli city-key-P">P</h3>
    <ul>
      <li data-name="莆田" data-id="58">莆田</li>
      <li data-name="攀枝花" data-id="336">攀枝花</li>
      <li data-name="濮阳" data-id="167">濮阳</li>
      <li data-name="平顶山" data-id="157">平顶山</li>
      <li data-name="萍乡" data-id="240">萍乡</li>
      <li data-name="盘锦" data-id="255">盘锦</li>
      <li data-name="普洱" data-id="378">普洱</li>
      <li data-name="平凉" data-id="72">平凉</li>
    </ul>
    <h3 class="cityhli city-key-Q">Q</h3>
    <ul>
      <li data-name="青岛" data-id="292">青岛</li>
      <li data-name="泉州" data-id="59">泉州</li>
      <li data-name="秦皇岛" data-id="145">秦皇岛</li>
      <li data-name="琼海" data-id="131">琼海</li>
      <li data-name="衢州" data-id="393">衢州</li>
      <li data-name="黔南" data-id="117">黔南</li>
      <li data-name="清远" data-id="87">清远</li>
      <li data-name="黔东南" data-id="116">黔东南</li>
      <li data-name="齐齐哈尔" data-id="177">齐齐哈尔</li>
      <li data-name="曲靖" data-id="377">曲靖</li>
      <li data-name="黔西南" data-id="118">黔西南</li>
      <li data-name="钦州" data-id="109">钦州</li>
      <li data-name="潜江" data-id="187">潜江</li>
      <li data-name="庆阳" data-id="73">庆阳</li>
      <li data-name="七台河" data-id="176">七台河</li>
      <li data-name="琼中" data-id="132">琼中</li>
    </ul>
    <h3 class="cityhli city-key-R">R</h3>
    <ul>
      <li data-name="日照" data-id="293">日照</li>
      <li data-name="日喀则" data-id="349">日喀则</li>
    </ul>
    <h3 class="cityhli city-key-S">S</h3>
    <ul>
      <li data-name="上海" data-id="321">上海</li>
      <li data-name="苏州" data-id="226">苏州</li>
      <li data-name="深圳" data-id="91">深圳</li>
      <li data-name="三亚" data-id="133">三亚</li>
      <li data-name="沈阳" data-id="256">沈阳</li>
      <li data-name="石家庄" data-id="146">石家庄</li>
      <li data-name="绍兴" data-id="389">绍兴</li>
      <li data-name="上饶" data-id="241">上饶</li>
      <li data-name="汕头" data-id="88">汕头</li>
      <li data-name="韶关" data-id="90">韶关</li>
      <li data-name="十堰" data-id="189">十堰</li>
      <li data-name="宿迁" data-id="227">宿迁</li>
      <li data-name="遂宁" data-id="337">遂宁</li>
      <li data-name="三明" data-id="60">三明</li>
      <li data-name="随州" data-id="190">随州</li>
      <li data-name="松原" data-id="218">松原</li>
      <li data-name="三门峡" data-id="158">三门峡</li>
      <li data-name="神农架林区" data-id="188">神农架林区</li>
      <li data-name="邵阳" data-id="204">邵阳</li>
      <li data-name="宿州" data-id="48">宿州</li>
      <li data-name="绥化" data-id="179">绥化</li>
      <li data-name="商丘" data-id="159">商丘</li>
      <li data-name="汕尾" data-id="89">汕尾</li>
      <li data-name="四平" data-id="217">四平</li>
      <li data-name="双鸭山" data-id="178">双鸭山</li>
      <li data-name="朔州" data-id="306">朔州</li>
      <li data-name="商洛" data-id="314">商洛</li>
      <li data-name="山南" data-id="350">山南</li>
      <li data-name="石嘴山" data-id="272">石嘴山</li>
    </ul>
    <h3 class="cityhli city-key-T">T</h3>
    <ul>
      <li data-name="台湾" data-id="34">台湾</li>
      <li data-name="台州" data-id="390">台州</li>
      <li data-name="天津" data-id="343">天津</li>
      <li data-name="太原" data-id="307">太原</li>
      <li data-name="泰安" data-id="294">泰安</li>
      <li data-name="泰州" data-id="228">泰州</li>
      <li data-name="唐山" data-id="147">唐山</li>
      <li data-name="通化" data-id="219">通化</li>
      <li data-name="天水" data-id="74">天水</li>
      <li data-name="铜陵" data-id="49">铜陵</li>
      <li data-name="通辽" data-id="266">通辽</li>
      <li data-name="铜仁" data-id="119">铜仁</li>
      <li data-name="铁岭" data-id="257">铁岭</li>
      <li data-name="铜川" data-id="315">铜川</li>
      <li data-name="吐鲁番" data-id="363">吐鲁番</li>
    </ul>
    <h3 class="cityhli city-key-W">W</h3>
    <ul>
      <li data-name="温州" data-id="391">温州</li>
      <li data-name="武汉" data-id="192">武汉</li>
      <li data-name="无锡" data-id="229">无锡</li>
      <li data-name="威海" data-id="295">威海</li>
      <li data-name="乌鲁木齐" data-id="364">乌鲁木齐</li>
      <li data-name="芜湖" data-id="50">芜湖</li>
      <li data-name="潍坊" data-id="296">潍坊</li>
      <li data-name="万宁" data-id="135">万宁</li>
      <li data-name="梧州" data-id="110">梧州</li>
      <li data-name="文昌" data-id="136">文昌</li>
      <li data-name="渭南" data-id="316">渭南</li>
      <li data-name="吴忠" data-id="273">吴忠</li>
      <li data-name="乌海" data-id="267">乌海</li>
      <li data-name="乌兰察布" data-id="268">乌兰察布</li>
      <li data-name="五指山" data-id="137">五指山</li>
      <li data-name="武威" data-id="75">武威</li>
      <li data-name="文山" data-id="379">文山</li>
    </ul>
    <h3 class="cityhli city-key-X">X</h3>
    <ul>
      <li data-name="西安" data-id="317">西安</li>
      <li data-name="厦门" data-id="61">厦门</li>
      <li data-name="徐州" data-id="230">徐州</li>
      <li data-name="西宁" data-id="281">西宁</li>
      <li data-name="湘西" data-id="206">湘西</li>
      <li data-name="襄阳" data-id="195">襄阳</li>
      <li data-name="西双版纳" data-id="380">西双版纳</li>
      <li data-name="咸宁" data-id="194">咸宁</li>
      <li data-name="湘潭" data-id="205">湘潭</li>
      <li data-name="咸阳" data-id="318">咸阳</li>
      <li data-name="宣城" data-id="51">宣城</li>
      <li data-name="新乡" data-id="160">新乡</li>
      <li data-name="锡林郭勒盟" data-id="269">锡林郭勒盟</li>
      <li data-name="许昌" data-id="162">许昌</li>
      <li data-name="忻州" data-id="308">忻州</li>
      <li data-name="新余" data-id="242">新余</li>
      <li data-name="孝感" data-id="196">孝感</li>
      <li data-name="信阳" data-id="161">信阳</li>
      <li data-name="兴城" data-id="4580">兴城</li>
      <li data-name="邢台" data-id="148">邢台</li>
      <li data-name="兴安盟" data-id="270">兴安盟</li>
      <li data-name="仙桃" data-id="193">仙桃</li>
    </ul>
    <h3 class="cityhli city-key-Y">Y</h3>
    <ul>
      <li data-name="扬州" data-id="232">扬州</li>
      <li data-name="烟台" data-id="297">烟台</li>
      <li data-name="银川" data-id="274">银川</li>
      <li data-name="宜昌" data-id="197">宜昌</li>
      <li data-name="盐城" data-id="231">盐城</li>
      <li data-name="营口" data-id="258">营口</li>
      <li data-name="运城" data-id="310">运城</li>
      <li data-name="延安" data-id="319">延安</li>
      <li data-name="岳阳" data-id="209">岳阳</li>
      <li data-name="延边" data-id="220">延边</li>
      <li data-name="益阳" data-id="207">益阳</li>
      <li data-name="雅安" data-id="338">雅安</li>
      <li data-name="榆林" data-id="320">榆林</li>
      <li data-name="玉林" data-id="111">玉林</li>
      <li data-name="鹰潭" data-id="244">鹰潭</li>
      <li data-name="阳江" data-id="92">阳江</li>
      <li data-name="玉溪" data-id="381">玉溪</li>
      <li data-name="阳泉" data-id="309">阳泉</li>
      <li data-name="宜春" data-id="243">宜春</li>
      <li data-name="永州" data-id="208">永州</li>
      <li data-name="宜宾" data-id="339">宜宾</li>
      <li data-name="云浮" data-id="93">云浮</li>
      <li data-name="伊春" data-id="180">伊春</li>
      <li data-name="伊犁" data-id="366">伊犁</li>
    </ul>
    <h3 class="cityhli city-key-Z">Z</h3>
    <ul>
      <li data-name="郑州" data-id="163">郑州</li>
      <li data-name="珠海" data-id="97">珠海</li>
      <li data-name="舟山" data-id="392">舟山</li>
      <li data-name="张家界" data-id="210">张家界</li>
      <li data-name="中山" data-id="96">中山</li>
      <li data-name="镇江" data-id="233">镇江</li>
      <li data-name="淄博" data-id="299">淄博</li>
      <li data-name="漳州" data-id="62">漳州</li>
      <li data-name="株洲" data-id="211">株洲</li>
      <li data-name="肇庆" data-id="95">肇庆</li>
      <li data-name="湛江" data-id="94">湛江</li>
      <li data-name="遵义" data-id="120">遵义</li>
      <li data-name="张家口" data-id="149">张家口</li>
      <li data-name="中卫" data-id="3105">中卫</li>
      <li data-name="枣庄" data-id="298">枣庄</li>
      <li data-name="驻马店" data-id="165">驻马店</li>
      <li data-name="张掖" data-id="76">张掖</li>
      <li data-name="资阳" data-id="340">资阳</li>
      <li data-name="自贡" data-id="341">自贡</li>
      <li data-name="周口" data-id="164">周口</li>
    </ul>
  </div>
  <ul class="city-nav"><li data-key="rm">直</li><li data-key="A">A</li><li data-key="B">B</li><li data-key="C">C</li><li data-key="D">D</li><li data-key="E">E</li><li data-key="F">F</li><li data-key="G">G</li><li data-key="H">H</li><li data-key="J">J</li><li data-key="K">K</li><li data-key="L">L</li><li data-key="M">M</li><li data-key="N">N</li><li data-key="P">P</li><li data-key="Q">Q</li><li data-key="R">R</li><li data-key="S">S</li><li data-key="T">T</li><li data-key="W">W</li><li data-key="X">X</li><li data-key="Y">Y</li><li data-key="Z">Z</li></ul>
</div>

<es:webAppNewFooter/>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>  
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script> 
<script type="text/javascript">
var getcity="${city}";//获得用户的城市
$(function(){
	//获得修改的城市，显示到页面位置
	//console.log("city=============="+getcity);
	if(getcity!==""){
		$("#city-wrapper ul li").each(function() {
			if ($(this).text() === getcity) {
				$(this).addClass("cur");
			}
		});
	}
		//点击城市进行修改操作
		$("#city-wrapper ul li").on("click", function() {
			//console.log("hhhhhhhhhhhhhhhhhhhhhhhhhh" + $(this).text());
			var ccity = $(this).text();
			$("#ccity").val(ccity);
			$("#form1").submit();
		});

	});
	if (!supportsGeoLocation()) {
		alert("不支持 GeoLocation.");
	}
	// 检测浏览器是否支持HTML5
	function supportsGeoLocation() {
		return !!navigator.geolocation;
	}
	// 单次位置请求执行的函数             
	function getLocation() {
		navigator.geolocation.getCurrentPosition(mapIt, locationError);
	}
	//定位成功时，执行的函数
	function mapIt(position) {
		var lon = position.coords.longitude;
		var lat = position.coords.latitude;
		// alert("您位置的经度是："+lon+" 纬度是："+lat);
		$("#lonint").val(lon);
		$("#latint").val(lat);

		var map = new BMap.Map("allmap");
		var point = new BMap.Point("" + lon + "", "" + lat + "");
		map.centerAndZoom(point, 19);
		var gc = new BMap.Geocoder();
		translateCallback = function(point) {
			var marker = new BMap.Marker(point);
			map.addOverlay(marker);
			map.setCenter(point);
			gc.getLocation(point, function(rs) {
				var addComp = rs.addressComponents;
				console.log("定位城市==="+ addComp.city);
				$("#pcy").css("display", "block");
				$("#positionCity").append(addComp.city);
				
				//地图定位的城市名称可能会有‘市’字，截掉后比较
				if(addComp.city.indexOf("市")!=-1){
					var hc=addComp.city.substring(0,addComp.city.indexOf("市"));
					//console.log("ppppppppppppppppppppp="+hc);
				}
				if(getcity===hc){
					$("#positionCity").addClass("cur");
				}
			});
		}
		BMap.Convertor.translate(point, 0, translateCallback);
	}
	// 定位失败时，执行的函数
	function locationError(error) {
		switch (error.code) {
		case error.PERMISSION_DENIED:
			alert("User denied the request for Geolocation.");
			break;
		case error.POSITION_UNAVAILABLE:
			alert("Location information is unavailable.");
			break;
		case error.TIMEOUT:
			alert("The request to get user location timed out.");
			break;
		case error.UNKNOWN_ERROR:
			alert("An unknown error occurred.");
			break;
		}
	}
	// 页面加载时执行getLocation函数
	window.onload = getLocation;
</script>

</body>
</html>