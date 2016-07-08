package com.zhuxiaoxue.service;

import com.zhuxiaoxue.mapper.RoleMapper;
import com.zhuxiaoxue.mapper.UserMapper;
import com.zhuxiaoxue.pojo.Role;
import com.zhuxiaoxue.pojo.User;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import javax.inject.Inject;
import javax.inject.Named;

@Named
public class ShiroRealm extends AuthorizingRealm {

    @Inject
    private UserMapper userMapper;

    @Inject
    private RoleMapper roleMapper;

    /**
     *验证用户是否具有某项权限
     * @param principalCollection
     * @return
     */

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        User user = (User) principalCollection.getPrimaryPrincipal();
        if(user != null){
            Integer roleid = user.getRoleid();
            Role role = roleMapper.findById(roleid);

            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
            info.addRole(role.getRolename());

            return info;
        }
        return null;
    }

    /**
     * 验证用户的账号和密码是否正确
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        String username = token.getUsername();
        User user = userMapper.findByUsername(username);

        if(user != null){
            if(!user.getEnable()){
                throw new LockedAccountException("该账号已被禁用");
            }
            return new SimpleAuthenticationInfo(user,user.getPassword(),getName());
        }else {
            System.out.println("登录出错");
            throw new UnknownAccountException("账号或密码错误");
        }
    }
}
