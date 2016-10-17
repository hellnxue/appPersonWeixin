package com.hrofirst.service;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.fnst.es.common.entity.search.Searchable;
import com.fnst.es.common.service.BaseService;
import com.github.sd4324530.fastweixin.message.BaseMsg;
import com.github.sd4324530.fastweixin.message.TextMsg;
import com.github.sd4324530.fastweixin.message.req.BaseEvent;
import com.github.sd4324530.fastweixin.message.req.BaseReq;
import com.github.sd4324530.fastweixin.message.req.BaseReqMsg;
import com.github.sd4324530.fastweixin.message.req.TextReqMsg;
import com.google.common.collect.Maps;
import com.hrofirst.entity.Menu;
import com.hrofirst.entity.WeChatUser;
import com.hrofirst.reflect.WeChatReflectMethod;
import com.hrofirst.repository.WeChatRepository;
import com.hrofirst.util.Config;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
@Service
public class WeChatService extends BaseService<WeChatUser, Long> {
    private static final Logger log = LoggerFactory.getLogger(WeChatService.class);
    public static HashMap<String, Method> methodMap = Maps.newHashMap();

    static {
        Method[] methods = WeChatReflectMethod.class.getDeclaredMethods();
        for (Method method : methods) {
            method.setAccessible(true);
            methodMap.put(method.getName(), method);
        }
    }

    @Autowired
    private MenuService menuService;

    private WeChatRepository getWeChatRepository() {
        return (WeChatRepository) baseRepository;
    }

    public WeChatUser findByUsername_bak(String userName) {
        return getWeChatRepository().findByUsername(userName);
    }

    /**
     * 根据用户名和apptype查询用户信息
     * @param userName
     * @param apptype
     * @return
     */
    public Page<WeChatUser> findByUsernameAndappType(String userName, String apptype) {
        Searchable searchable =
                Searchable.newSearchable().addSearchParam("username_eq", userName).addSearchParam("apptype_eq", apptype);
        return findAll(searchable);
    }
    /**
     * 处理用findByUsernameAndappType方法查询的用户
     */
    public WeChatUser findWeChatUser(String username,String apptype){
    	WeChatUser user=null;
    	List<WeChatUser> userList = findByUsernameAndappType(username, apptype).getContent();
    	if(userList!=null && userList.size()>0){
    		user=userList.get(0);
    	}
    	return user;
    }
    
    public WeChatUser save(WeChatUser weChatUser) {
        return getWeChatRepository().save(weChatUser);
    }

    public WeChatUser saveFollowTime(String weChatUser,String apptype) {
        WeChatUser user = findWeChatUser(weChatUser,apptype);
        if (user != null) {
            user.setFollowDate(new Date());
            user = save(user);
        }
        return user;
    }

    public WeChatUser unSubscribe(String weichatId,String apptype) {
        WeChatUser weChatUser = findWeChatUser(weichatId,apptype);
        if (weChatUser != null) {
            weChatUser.setCurrentMenu(null);
            weChatUser.setIdCard(null);
        }
        return weChatUser;
    }

    public WeChatUser updateMenuId(String weichatId,String apptype, Long menuId) {
        WeChatUser weChatUser = findWeChatUser(weichatId,apptype);
        if (weChatUser != null) {
            weChatUser.setCurrentMenu(menuId);
        }
        return weChatUser;
    }

    public WeChatUser updateMenuId(WeChatUser weChatUser, Long menuId) {
        if (weChatUser != null) {
            weChatUser.setCurrentMenu(menuId);
        }
        return weChatUser;
    }

    public Menu findByWeiChatAndKeyWord(String weichatId,String apptype, String keyWord) {
        WeChatUser weChatUser = findWeChatUser(weichatId,apptype);
        if (weChatUser != null) {
            Menu menu = menuService.findByKeywordAndPId(keyWord, weChatUser.getCurrentMenu());
            if (menu != null) {
                weChatUser = updateMenuId(weChatUser, menu.getId());
            } else {
                //keywords 错误则自动返回最上级
                updateMenuId(weChatUser, null);
            }
            return menu;
        }
        return null;
    }

    //处理员工帮手菜单指令
    public BaseMsg checkPersonUserAndResponseMenu(BaseReq arg) {

        if (arg == null || arg instanceof BaseEvent) {
            //weChat error
            return null;
        }
        String weichatId = arg.getFromUserName();
        WeChatUser user = null;
        if (weichatId != null) {
        	//查找用户
            user = findWeChatUser(weichatId,"weixinPerson");
            if (user == null) {
            	//创建用户
                user = new WeChatUser(weichatId);
                //设置appType
                user.setApptype("weixinPerson");
            }
            //修改用户的最后操作时间
            user.setLastAccessDate(new Date());
//            //只接受菜单2，上传资料的操作
//            user.setCurrentMenu((long) 2);
            user = save(user);
        }
       
        Long menuId = user.getCurrentMenu();
        Menu menu = menuService.findOne(menuId);
        Menu nextMenu;
        TextMsg msg = new TextMsg();

        if (arg instanceof TextReqMsg) {
            if (((TextReqMsg) arg).getContent().equals(Config.getWechatBackKey())) {
            	//0 返回顶级菜单
                return showParentMenu(user, menuId, menu, msg);
            } else if (((TextReqMsg) arg).getContent().equals(Config.getWechatMenuKey())) {
            	//1返回主菜单
                return showMenu(menuId, menu, msg,1);
            }  else if (menuService.findOne(menuId)!= null) {//测试
            	//System.out.println(menuService.findOne(menuId));
            	//输入错误指令菜单的处理
                //msg.addln(Config.getWechatErrorMenu());
               // return showMenu(menuId, menu, msg,2);
            	msg.add("success");//指定公众号不回复内容
                return null;
            }else if (null != (nextMenu = menuService.findByKeywordAndPId(((TextReqMsg) arg).getContent(), null))) {
                //输入菜单指令处理
                updateMenuId(weichatId, "weixinPerson",nextMenu.getId());//修改用户的currentMenu为菜单对应的keyword值
                return showMenu(nextMenu.getId(), nextMenu, msg,1);
            }
        }

        if (menu != null && (menu.getType() != null && !menu.getType().toLowerCase().contains(
                arg.getClass().getSimpleName().replace("ReqMsg", "").toLowerCase()))) {
            //error response
            msg.addln(Config.getWechatErrorInput());
            return showMenu(menuId, menu, msg,2);

        } else if (menu == null && arg instanceof BaseReqMsg) {//测试
        	msg.add("success");//指定公众号不回复内容
            return null;
           // return showTopMenu(msg);
        } else {
            try {
                return handleReflect(arg, menu);
            } catch (InvocationTargetException e) {
                log.error(e.getMessage(), e);
            } catch (IllegalAccessException e) {
                log.error(e.getMessage(), e);
            }
        }
        return null;
    }

    private BaseMsg handleReflect(BaseReq baseReq, Menu menu) throws InvocationTargetException, IllegalAccessException {
        if (menu != null) {
            Method method = methodMap.get(menu.getOperation());
            if (method != null) {
                String[] arguments = null;
                if (menu.getArgument() != null) {
                    arguments = menu.getArgument().split(",");
                }

                Class<?>[] types = method.getParameterTypes();
                if (arguments != null && arguments.length != types.length - 1) {
                    //error some arguments missing
                    log.error("arguments length!=types.length-1");
                    return null;

                }
                Object[] params = new Object[types.length];
                if (arguments != null && arguments.length >= 1) {
                    System.arraycopy(arguments, 0, params, 0, arguments.length);
                }
                params[params.length - 1] = baseReq;
                //static method
                return (BaseMsg) method.invoke(null, params);
            }
        }
        return null;
    }
    //顶级菜单 
    private TextMsg showParentMenu(WeChatUser user, Long menuId, Menu menu, TextMsg msg) {
        List<Menu> menus;
        if (menuId == null) {
            //show top menu
        	//根据菜单的pId与appType查询对应的菜单集
            Page<Menu> mm = menuService.findByPidAndApptype(null, "weixinPerson");
            menus = (List<Menu>) mm.getContent();
        } else {
            if (menu != null) {
            	//设置currentMenu为空
                user.setCurrentMenu(menu.getpId());
                user = save(user);
                //根据菜单的pId与appType查询对应的菜单集
                Page<Menu> mm = menuService.findByPidAndApptype(menu.getpId(), "weixinPerson");
                menus = (List<Menu>) mm.getContent();
            } else {
            	//根据菜单的pId与appType查询对应的菜单集
                Page<Menu> mm = menuService.findByPidAndApptype(null, "weixinPerson");
                menus = (List<Menu>) mm.getContent();
            }
        }
        buildMenus(msg, menus);
        return msg;
    }

    public TextMsg showTopMenu(TextMsg msg) {
        return showMenu(null, null, msg,1);
    }

    /**
     * 
     * @param menuId
     * @param menu
     * @param msg
     * @param flag 输入错误的菜单时flag设置为2，处理正确的菜单返回信息
     * @return
     */
    private TextMsg showMenu(Long menuId, Menu menu, TextMsg msg,int flag) {
        List<Menu> menus;
        if (menuId == null) {
            //show top menu
             //输入有误时，根据pid和apptype查询菜单项集合
        	  Page<Menu> mm = menuService.findByPidAndApptype(null, "weixinPerson");
              menus = (List<Menu>) mm.getContent();
              buildMenus(msg, menus);
        } else {
        	 //根据输入的keyword和appType查询菜单项
        	 Page<Menu> mm= menuService.findByKeywordAndAppType(menu.getKeyword(), "weixinPerson");
              menus = (List<Menu>) mm.getContent();
            if (menu != null) {
                msg.add(menu.getDetail()).addln().add(menu.getDesc()).addln();
            }
            	//输入正确时组建菜单，没有默认提示wechat_menu_des
              	buildMenus(msg, null);

        }
        return msg;
    }

    private static void buildMenus(TextMsg msg, List<Menu> menus) {
        if (menus != null && !menus.isEmpty()) {
            msg.add(Config.getWechatMenuDesc()).addln();
            for (Menu menuTmp : menus) {
                msg.add(menuTmp.getKeyword()).add(":").add(menuTmp.getDetail()).addln();
            }
        }
        msg.addln()
                .add("按").add(Config.getWechatBackKey()).addln("返回上级菜单")
                .add("按").add(Config.getWechatMenuKey()).addln("显示菜单");
    }
    
	/**
	 * 根据登录用户名和登录微信帮手类型按时间排序，取最晚时间的用户
	 * 
	 * @param userName
	 *            用户名
	 * @param apptype
	 *            微信帮手类型
	 * @return
	 */
	public WeChatUser getWeChatUserOpenId(String userName, String apptype) {
		Searchable searchable = Searchable.newSearchable()
				.addSearchParam("username_eq", userName)
				.addSearchParam("apptype_eq", apptype)
				.addSort(Sort.Direction.DESC, "last_access_date");
		List<WeChatUser> weChatUsers = findAll(searchable).getContent();
		if (weChatUsers != null && weChatUsers.size() > 0) {
			return weChatUsers.get(0);
		}
		return null;
	}
	/**
	 * 根据类型和智阳用户名查询
	 * <pre>
	 * @author steven.chen
	 * @date 2016年5月24日 上午10:28:30 
	 * </pre>
	 *
	 * @param zhiyangUserName
	 * @param apptype
	 * @return
	 */
	public WeChatUser getWeChatUserByZhiYangUserName(String zhiyangUserName, String apptype) {
		Searchable searchable = Searchable.newSearchable()
				.addSearchParam("zhiyangUserName_eq", zhiyangUserName)
				.addSearchParam("apptype_eq", apptype)
				.addSort(Sort.Direction.DESC, "last_access_date");
		List<WeChatUser> weChatUsers = findAll(searchable).getContent();
		if (weChatUsers != null && weChatUsers.size() > 0) {
			return weChatUsers.get(0);
		}
		return null;
	}
}