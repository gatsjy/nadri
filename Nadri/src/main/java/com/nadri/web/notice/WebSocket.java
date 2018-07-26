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

import org.springframework.web.bind.annotation.RequestBody;

@ServerEndpoint("/websocket/{userId}")
public class WebSocket {
    /***
     * �� ������ ����Ǹ� ȣ��Ǵ� �̺�Ʈ
     */
	  static Map<String, Session> map =Collections.synchronizedMap(new HashMap<String , Session>()) ;
	
    @OnOpen
    public void handleOpen(@PathParam("userId") String userId , Session session) {
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
    	System.out.println("userId : " + userId.toString() ) ;
    	System.out.println("������ ���� :" + userId.substring(userId.length() -1 , userId.length() )) ;
    	switch (userId.substring(userId.length() - 1 , userId.length() )) {
    	
    	//�Ű��� ��
    	case "0" :
    		if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    			map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("�Ű� �޽���") ;
    		}
    		break ;
    	//���ƿ��� ��
    	case "1" :
    		if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    			map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("���ƿ� �޽���.") ;
    		}
    		break ;
    	//ģ����û�� ��
    	case "2" :
    		if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    			map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("ģ����û �޽���.") ;
    		}
    		break ;
    	//�ױ����� ��
    	case "3" :
    		for(int i = 0 ; i < userIdArray.length ; i++) {
    			if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    				map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("��ũ �޽���.") ;
    			}
    		}
    		break ;
    	
    	//��� ������ ��
    	case "4" :
    		for(int i = 0 ; i < userIdArray.length ; i++) {
    			if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    				map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("��� �޽���.") ;
    			}
    		}
    		break ;
    		
    	//ä���� ��
    	default :
    		for(int i = 0 ; i < userIdArray.length ; i++) {
        		if( map.get( userIdArray[i].substring( 0 , userIdArray[i].length() - 1 ) ) != null && userIdArray[i].substring(userIdArray[i].length() - 1 , userIdArray[i].length()).equals("5")  ) {
                	map.get( userIdArray[i].substring( 0 , userIdArray[i].length() - 1 ) ).getBasicRemote().sendText("ä�� �޽���.") ;
        		}
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
