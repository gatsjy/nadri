package com.nadri.common;

import java.util.ArrayList;

public class SuffixParsing {
   public SuffixParsing() {
      
   }
   
   public ArrayList<String> parsing(String sentence) {
      ArrayList<String> temp = new ArrayList<String>() ;
      int index = 0 ;
      while( true ) {
         
         if( sentence.indexOf("�� ") != -1 ) {
            
            index = sentence.indexOf("��") ;
//            System.out.println("��");
         }
         else if( sentence.indexOf("�� ") != -1 ) {
            
            index = sentence.indexOf("��") ;
//            System.out.println("��");
         } 
         else if( sentence.indexOf("���� ") != -1 ) {
            
            index = sentence.indexOf("����") ;
//            System.out.println("����");
         } 
         else if( sentence.indexOf("���Լ� ") != -1 ) {
            
            index = sentence.indexOf("���Լ�") ;
//            System.out.println("���Լ�");
         }
         else if( sentence.indexOf("���� ") != -1 ) {
            
            index = sentence.indexOf("����") ;
//            System.out.println("����");
         }  
         else if( sentence.indexOf("���� ") != -1 ) {
            
            index = sentence.indexOf("����") ;
//            System.out.println("����");
         }  
         else if( sentence.indexOf("���� ") != -1 ) {
            
            index = sentence.indexOf("����") ;
//            System.out.println("����");
         } 
         else if( sentence.indexOf("���� ") != -1 ) {
            
            index = sentence.indexOf("����") ;
//            System.out.println("����");
         } 
         else if( sentence.indexOf("�� ") != -1 ) {
            
            index = sentence.indexOf("��") ;
//            System.out.println("��");
         } 
         else if( sentence.indexOf("�� ") != -1 ) {
            
            index = sentence.indexOf("��") ;
//            System.out.println("��");
         } 
         else if( sentence.indexOf("�� ") != -1 ) {
            
            index = sentence.indexOf("��") ;
//            System.out.println("��");
         } 
         else if( sentence.indexOf("���� ") != -1 ) {
            
            index = sentence.indexOf("����") ;
//            System.out.println("����");
         } 
         else if( sentence.indexOf("�� ") != -1 ) {
            
            index = sentence.indexOf("��")  ;
//            System.out.println("��");
         } 
         else if( sentence.indexOf("�� ") != -1 ) {
         
            index = sentence.indexOf("�� ") ;
//            System.out.println("��");
         } 
         else if( sentence.indexOf("�� ") != -1 ) {
         
            index = sentence.indexOf("��") ;
//            System.out.println("��");
         } 
         else if( sentence.indexOf("�μ� ") != -1 ) {
            
            index = sentence.indexOf("�μ�") ;
//            System.out.println("�μ�");
         } 
         else if( sentence.indexOf("���� ") != -1 ) {
            
            index = sentence.indexOf("���� ") ;
//            System.out.println("����");
         } 
         else if( sentence.indexOf(".") != -1 ) {
            
            index = sentence.indexOf(".") ;
//            System.out.println(".");
         }
         else if( sentence.indexOf("�� ") != -1 ) {
            
            index = sentence.indexOf("�� ") ;
//            System.out.println("�� ");
         } 
         else if( sentence.indexOf("�� ") != -1) {
            
            index = -1 ;
//            System.out.println("�� ");
         } 
         else if( sentence.indexOf("�� ") != -1) {
            
            index = -1 ;
//            System.out.println("�� ");
         } 
         else if( sentence.indexOf("�� ") != -1) {
            
            index = -1 ;
//            System.out.println("�� ");
         } 
         else if( sentence.indexOf("�� ") != -1) {
            
            index = -1 ;
//            System.out.println("�� ");
         }
         //���� ��ġ�� ���� fix
         else if( sentence.indexOf(" ") != -1 ) {
            
            index = sentence.indexOf(" ") ;
//            System.out.println("����");
         }
         
         //������ ����
         else if( sentence.indexOf("��?") != -1) {
            
            index = -1 ;
//            System.out.println("��? ù��° ����");
         }
         else if( sentence.indexOf("����") != -1) {
            
            index = -1 ;
//            System.out.println("����");
         }
         
         else if( sentence.indexOf("��") != -1) {
   
               index = -1 ;
//               System.out.println("�� ");
         }
         else if( sentence.indexOf("��.") != -1) {
            
            index = -1 ;
//            System.out.println("�� ");
         }
         //�� �ܾ �˻� ��
         else {
            if( !sentence.trim().equals("") ) {
               temp.add(sentence) ;
            }
            break ;
         }
         
         
         
         if( index == 0 ) {
            break ;
         } else if( index == -1 ) {
            if( sentence.indexOf("�� ") != -1) {
               
               index = sentence.indexOf("��") ;
//               System.out.println("�� ");
            } 
            else if( sentence.indexOf("�� ") != -1) {
               
               index = sentence.indexOf("��") ;
//               System.out.println("�� ");
            } 
            else if( sentence.indexOf("�� ") != -1) {
               
               index = sentence.indexOf("��") ;
//               System.out.println("�� ");
            } 
            else if( sentence.indexOf("�� ") != -1) {
               
               index = sentence.indexOf("��") ;
//               System.out.println("�� ");
            }
            else if( sentence.indexOf("��?") != -1) {
               
               index = sentence.indexOf("��?") + 1 ;
//               System.out.println("��?") ;
            }
            else if( sentence.indexOf("����") != -1) {
               
               index = sentence.indexOf("����") + 1;
//               System.out.println("����");
            }
            else if( sentence.indexOf("��.") != -1) {
               
               index = sentence.indexOf("��.") + 1;
//               System.out.println("�� ");
            }
            else if( sentence.indexOf("��") != -1) {
   
               index = sentence.indexOf("��") ;
//               System.out.println("�� ");
            }
            
            sentence = sentence.substring( index + 1 , sentence.length()).trim() ;
            index = 0 ;
         }
         
         else {
            if( sentence.substring( 0 , index ) != "" && sentence != "") {
//               System.out.println("���� ");
               temp.add( sentence.substring( 0 , index )) ;
//               System.out.println("�� �� : " + sentence.substring( 0 , index )) ;
            }
            sentence = sentence.substring( index + 1 , sentence.length()).trim() ;
//            System.out.println("���� �� : " + sentence) ;
            index = 0 ;
         }
      }
      return temp ;
   }
}