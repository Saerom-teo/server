package com.saeromteo.app.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import com.zaxxer.hikari.HikariDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

@WebListener
@Component
public class MYSQLListener implements ServletContextListener {

    @Autowired
    private HikariDataSource dataSource;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 애플리케이션 초기화 시 필요한 작업을 여기에 작성
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 애플리케이션 종료 시 리소스 정리
        try {
            if (dataSource != null) {
                dataSource.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            AbandonedConnectionCleanupThread.checkedShutdown();
        }
    }
}
