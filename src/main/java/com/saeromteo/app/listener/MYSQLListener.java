package com.saeromteo.app.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

public class MYSQLListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 애플리케이션 초기화 시 필요한 작업을 여기에 작성
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 애플리케이션 종료 시 리소스 정리
        AbandonedConnectionCleanupThread.checkedShutdown();
    
    }
}