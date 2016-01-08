package com.hrofirst.service;

import com.fnst.es.common.entity.search.Searchable;
import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.News;
import com.hrofirst.push.ClientPushService;
import com.hrofirst.repository.NewsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * Created by qixb.fnst on 2015/02/12.
 */
@Service
public class NewsService extends BaseService<News, Long> {
    @Autowired
    private ClientPushService clientPushService;

    @Autowired
    private NewsRepository getNewsRepository() {
        return (NewsRepository) baseRepository;
    }

    public void markRead(long id) {
        News news = findOne(id);
        if (news != null) {
            news.setRead(true);
            news.setReadTime(new Date());
            update(news);
        }
    }

    public Page<News> findByReceiverAndType(String receiver, News.NewsType type, int pageCount, int pageSize) {
        Searchable searchable =
                Searchable.newSearchable().addSearchParam("type_eq", type).setPage(new PageRequest(pageCount, pageSize)).addSort(Sort.Direction.ASC, "read").addSort(Sort.Direction.DESC, "sendTime");
        if (type != News.NewsType.PUBLIC) {
            searchable.addSearchParam("receiver_eq", receiver);
        }
        return findAll(searchable);
    }


    public long countUnRead(String receiver, News.NewsType type) {
        Searchable searchable =
                Searchable.newSearchable().addSearchParam("type_eq", type).addSearchParam("receiver_eq", receiver).addSearchParam("read_eq", false);
        return count(searchable);
    }

    public News save(News m) {
        News news = getNewsRepository().save(m);
        //TODO  push
        return news;
    }
}
