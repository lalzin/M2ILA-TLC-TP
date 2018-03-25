/*
 * Copyright 2016 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//[START all]

package com.example.category;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//[START all]
public class SignCategoryServlet extends HttpServlet {
	// Process the HTTP POST of the form
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		Ads ads;

		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser(); // Find out who the user is.
		
		String action = req.getParameter("action");
		String searchCriteria = req.getParameter("searchCriteria");
		String valueDelete = req.getParameter("delete");
		String categoryName = req.getParameter("categoryName");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String listAds = req.getParameter("listAds");
		
		double price = -1;
		if (req.getParameter("price") != null) {
			try {
				price = Double.parseDouble(req.getParameter("price"));
			} catch (Exception ex) {
				price = 0;
			}
		}

		if (valueDelete != null && categoryName != null) {

			Category category = new Category(categoryName);
			ads = category.searchAds(valueDelete);
			ads.delete();

		} else if (categoryName != null && title != null && content != null) {

			ads = new Ads(categoryName, content, price, title);

			ads.save();

		} else if (listAds != null) {

			String[] lines = listAds.split(System.getProperty("line.separator"));

			for (int i = 0; i < lines.length; i++) {
				String[] elements = lines[i].split(";");
				if (elements.length == 3) {
					title = elements[0];
					try {
						price = Double.parseDouble(elements[1]);
					} catch (Exception ex) {
						price = 0;
					}
					content = elements[2];
					ads = new Ads(categoryName, content, price, title);

					ads.save();
				}

			}

		}
		if(searchCriteria!= null) {
			if(action.equals("delete_all")) {
				
				Category category = new Category(categoryName);
				List<Ads> adss = category.getAdss(searchCriteria);
				for(Ads adsToDeleted : adss) {
					adsToDeleted.delete();
				}

				resp.sendRedirect("/category.jsp?categoryName=" + categoryName);
			} else if(action.equals("search")) {
				resp.sendRedirect("/category.jsp?categoryName=" + categoryName+"&searchCriteria="+searchCriteria);
			}
		} else {
			resp.sendRedirect("/category.jsp?categoryName=" + categoryName);
		}

	}
}
// [END all]
