package com.zhuxiaoxue.service;

import com.google.common.collect.Maps;
import com.zhuxiaoxue.mapper.RoleMapper;
import com.zhuxiaoxue.mapper.UserLogMapper;
import com.zhuxiaoxue.mapper.UserMapper;
import com.zhuxiaoxue.pojo.Role;
import com.zhuxiaoxue.pojo.User;
import com.zhuxiaoxue.pojo.UserLog;
import com.zhuxiaoxue.util.ShiroUtil;
import org.apache.commons.codec.digest.DigestUtils;
import org.joda.time.DateTime;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class UserService {

    @Inject
    private UserMapper userMapper;

    @Inject
    private UserLogMapper userLogMapper;

    @Inject
    private RoleMapper roleMapper;


    public void saveUserLogin(String ip) {
        UserLog userlog = new UserLog();
        userlog.setLoginip(ip);
        userlog.setLogintime(DateTime.now().toString("yyyy-MM-dd HH:mm"));
        userlog.setUserid(ShiroUtil.getCurrentUserId());

        userLogMapper.save(userlog);
    }

    public List<UserLog> findCurrentUserLog(String start, String length) {

        Map<String,Object> params = Maps.newHashMap();
        params.put("userid",ShiroUtil.getCurrentUserId());
        params.put("start",start);
        params.put("length",length);

        return userLogMapper.findByParams(params);

    }

    public Long findCurrentUserLogcount() {

        Map<String,Object> map = Maps.newHashMap();
        map.put("userId",ShiroUtil.getCurrentUserId());
        return userLogMapper.countByUserid(map);
    }

    public void changePassword(String password) {
        User user = ShiroUtil.getCurrentUser();
        user.setPassword(password);
        userMapper.update(user);
    }

    public List<User> findUserlistByParams(Map<String, Object> params) {
        return userMapper.findAllByParams(params);
    }

    public Long findUserCount() {
        return userMapper.count();
    }

    public Long findUserCountByParams(Map<String, Object> params) {
        return userMapper.countByParams(params);
    }

    public List<Role> findAllRole() {
        return roleMapper.findAll();
    }

    public void addUser(User user) {
        user.setPassword(DigestUtils.md5Hex(user.getPassword()));
        userMapper.save(user);
    }

    public User findUserByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    /**
     * 重置密码
     * @param id
     */
    public void resetPasswordById(Integer id) {
        User user = userMapper.findUserById(id);
        user.setPassword(DigestUtils.md5Hex("000000"));
        userMapper.update(user);
    }

    public User findUserById(Integer id) {
        return userMapper.findUserById(id);
    }

    public void updateUser(User user) {
        userMapper.update(user);
    }

    public List<User> findAll() {
        return userMapper.findAll();
    }
}
