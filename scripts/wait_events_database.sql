SELECT getdate() as 'Run_Time' --script running time
    , wait_type --wait type
    ,waiting_tasks_count
	, CAST(wait_time_ms / 1000. AS DECIMAL(12, 2)) AS wait_time_s --saniye cinsinden bekleme zaman�
	, CAST(100. * wait_time_ms / SUM(wait_time_ms) OVER() AS DECIMAL(12, 2)) AS pct --toplam beklemeye oran�
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN ('BROKER_TASK_STOP','Total','SLEEP','BROKER_EVENTHANDLER','BROKER_RECEIVE_WAITFOR',
      'BROKER_TRANSMITTER','CHECKPOINT_QUEUE','CHKPT,CLR_AUTO_EVENT','CLR_MANUAL_EVENT','KSOURCE_WAKEUP','LAZYWRITER_SLEEP',
      'LOGMGR_QUEUE','ONDEMAND_TASK_QUEUE','REQUEST_FOR_DEADLOCK_SEARCH','RESOURCE_QUEUE','SERVER_IDLE_CHECK',
      'SLEEP_BPOOL_FLUSH','SLEEP_DBSTARTUP','SLEEP_DCOMSTARTUP','SLEEP_MSDBSTARTUP','SLEEP_SYSTEMTASK','SLEEP_TASK',
      'SLEEP_TEMPDBSTARTUP','SNI_HTTP_ACCEPT','SQLTRACE_BUFFER_FLUSH','TRACEWRITE','WAIT_FOR_RESULTS','WAITFOR_TASKSHUTDOWN',
       'XE_DISPATCHER_WAIT','XE_TIMER_EVENT','WAITFOR')
ORDER BY 4 DESC