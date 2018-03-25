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

import static com.example.category.Persistence.getDatastore;

import com.google.cloud.datastore.DateTime;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.FullEntity;
import com.google.cloud.datastore.FullEntity.Builder;
import com.google.cloud.datastore.IncompleteKey;
import com.google.cloud.datastore.Key;
import com.google.common.base.MoreObjects;

import java.util.Date;
import java.util.Objects;

public class Ads {
  private Category category;

  public Key key;
  public String title;
  public double price;
  public String content;
  public Date date;

  public Ads() {
    date = new Date();
  }

  public Ads(String category, String content) {
    this();
    this.category = new Category(category);
    this.content = content;
  }

  public Ads(String book, String content, double price, String title) {
    this(book, content);
    this.title = title;
    this.price = price;
  }

  public Ads(Entity entity) {
    key = entity.hasKey() ? entity.key() : null;
    title = entity.contains("title") ? entity.getString("title") : null;
    price = entity.contains("price") ? entity.getDouble("price") : null;
    date = entity.contains("date") ? entity.getDateTime("date").toDate() : null;
    content = entity.contains("content") ? entity.getString("content") : null;
  }

  public void save() {
    if (key == null) {
      key = getDatastore().allocateId(makeIncompleteKey()); // Give this ads a unique ID
    }

    Builder<Key> builder = FullEntity.builder(key);

    if (title != null) {
      builder.set("title", title);
    }

    builder.set("price", price);
    builder.set("content", content);
    builder.set("date", DateTime.copyFrom(date));

    getDatastore().put(builder.build());
  }

  public void delete() {
	  if(key != null) {
	    getDatastore().delete(key);
	  }
	  
  }
  private IncompleteKey makeIncompleteKey() {
    // The book is our ancestor key.
    return Key.builder(category.getKey(), "Ads").build();
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    Ads ads = (Ads) o;
    return Objects.equals(key, ads.key)
        && Objects.equals(title, ads.title)
        && Objects.equals(price, ads.price)
        && Objects.equals(content, ads.content)
        && Objects.equals(date, ads.date);
  }

  @Override
  public int hashCode() {
    return Objects.hash(key, title, price, content, date);
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .add("key", key)
        .add("title", title)
        .add("price", price)
        .add("content", content)
        .add("date", date)
        .add("category", category)
        .toString();
  }

}
//[END all]
