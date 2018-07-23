package com.nadri.web.notice;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/websocket/{userId}")
public class WebSocket {
    /***
     * �� ������ ����Ǹ� ȣ��Ǵ� �̺�Ʈ
     */
	  static Map<String, Session> map =Collections.synchronizedMap(new HashMap<String , Session>()) ;
	
    @OnOpen
    public void handleOpen(@PathParam("userId") String userId , Session session) {
    	System.out.println("123") ;
        map.put( userId  , session) ;
    }
    
    /**
     * �� �������κ��� �޽����� ���� ȣ��Ǵ� �̺�Ʈ
     * @param message
     * @return
     * @throws IOException 
     */
    @OnMessage
    public void handleMessage( String userId  , Session session) throws IOException {
    	//���� ������Ƽ�� username�� ������ username�� �����ϰ� �ش� ���������� �޽����� ������.(json �����̴�.)
        //���� �޽����� username����
    	String[] userIdArray = userId.split(",") ;
    	
    	for(int i = 0 ; i < userIdArray.length ; i++) {
    		if( map.get( userIdArray[i].substring( 0 , userIdArray[i].length() - 1 ) ) != null && userIdArray[i].substring(userIdArray[i].length() - 1 , userIdArray[i].length()).equals("0")  ) {
            	map.get( userIdArray[i].substring( 0 , userIdArray[i].length() - 1 ) ).getBasicRemote().sendText("�����κ��� ���� �޽���.") ;
    		}
    	}
    	
    }
    /**
     * �� ������ ������ ȣ��Ǵ� �̺�Ʈ
     */
    @OnClose
    public void handleClose() {
        
    }
    /**
     * �� ������ ������ ���� ȣ��Ǵ� �̺�Ʈ
     * @param t
     */
    @OnError
    public void handleError(Throwable t) {
        t.printStackTrace() ;
    }
}
