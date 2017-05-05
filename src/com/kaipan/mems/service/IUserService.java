package com.kaipan.mems.service;

import com.kaipan.mems.domain.Userinfo;

public interface IUserService {

	public Userinfo login(Userinfo model);

	public void editPassword(String password, String id);

	public void update(Userinfo user);
}
