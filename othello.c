#include <stdio.h>
int main(){

int curr[8][8] ; ////gives current status of the game
int chance, score1 =2 ,score2 =2 ; ///chance gives the int representing number of current playing player
int full=0 ; // full=true if 8*8 matrix gets fully filled 
int winner =0; ///winner will be get decided after full== true 
///                                      ALL THING ARE ZERO_ENUMERATED
//start status
for(int i=0;i<8;i++){
	for(int j=0;j<8;j++){
		curr[i][j]=0 ;
	}
}
  int score2temp,score1temp;              ///ForKeBaad:
curr[3][4]=1 ;
curr[4][3]=1 ;
curr[3][3]=2 ;
curr[4][4]=2 ;

int count=4 ;
int x,y;
int xcopy;
printf(" Initial - \nscore1=%d\nscore2=%d",score1,score2 );

               //////////////// Whilellop

while(full != 1 ){
		scanf("%d%d%d", &chance,&x, &y ) ;
    printf("\n");
          if (x>7 || y>7) printf("not a valid choice\n");
          else if (chance>2)printf("not a valid choice\n");
		else if(curr[x][y]!=0){
		printf("not a valid choice\n");
		}

		else {
      curr[x][y]=chance ;
//checking full
count++ ;
if(count==64)full=1 ;
                        ///  KEEPON
   //chance-->1 player 1(black) &&& chance-->2 player 2(white)
 /// UP
           for(int i = y+1; i < 8 ; i++){
                  if(curr[x][i] == 0)break ;
                 if( curr[x][i] == curr[x][y]){
                              int diff = i - y-1;
                     while(diff > 0){
                         curr[x][y+diff] = chance;
                             diff--;
                          }
                 break ; }
                }
////DOWN 
                    for(int i = y-1; i >= 0 ; i--){
              if(curr[x][i] == 0)break ;
          if( curr[x][i] == curr[x][y]){
            int diff = y- i - 1;
            while(diff > 0){
                    curr[x][y-diff] = chance;
                    diff--;
                         }
                       break;             }
                                                  }
       

//LEFT
    for(int i = x-1; i >=0 ; i--){
          if(curr[i][y] == 0)break ;
          if( curr[i][y] == curr[x][y]){
            int diff = x - i - 1;
            while(diff > 0){
                    curr[x-diff][y] = chance;
                    diff--;
            }
        }
    }                                                  
//RIGHT
    for(int i = x+1; i < 8 ; i++){
           if(curr[i][y] == 0)break ;
          if( curr[i][y] == curr[x][y]){
            int diff = i - x - 1;

            while(diff > 0){
                    curr[x+diff][y] = chance;
                    diff--;
            }
       break ; }
    }                                                  
//up-right
    xcopy =x;
           for(int i = y+1; i < 8 ; i++){
           	xcopy++ ;
           	     if(xcopy==8) break ;
           	     if(curr[xcopy][i] == 0)break ;
                 if(curr[xcopy][i] == curr[x][y]){
                              int diff = i - y-1;
                     while(diff > 0){
                         curr[x+diff][y+diff] = chance;
                             diff--;
                          }
                break ;  }
                }                
//up-left
    xcopy =x;
           for(int i = y+1; i < 8 ; i++){
           	xcopy-- ;
           	     if(xcopy==-1) break ;
           	     if(curr[xcopy][i] == 0)break ;
                 if(curr[xcopy][i] == curr[x][y]){
                              int diff = i - y-1;
                     while(diff > 0){
                         curr[x-diff][y+diff] = chance;
                             diff--;
                          }
                break ;  }
                }                

///down-left
    xcopy =x;
           for(int i = y-1; i >=0 ; i--){
           	xcopy-- ;
           	     if(xcopy==-1) break ;
           	     if(curr[xcopy][i] == 0)break ;
                 if(curr[xcopy][i] == curr[x][y]){
                              int diff =  y-i-1;
                     while(diff > 0){
                         curr[x-diff][y-diff] = chance;
                             diff--;
                          }
                break ;  }
                }              
//down-right
    xcopy =x;
           for(int i = y-1; i >= 0 ; i--){
           	xcopy++ ;
           	     if(xcopy==8) break ;
           	     if(curr[xcopy][i] == 0)break ;
                 if(curr[xcopy][i] == curr[x][y]){
                              int diff = y-i-1;
                     while(diff > 0){
                         curr[x+diff][y-diff] = chance;
                             diff--;
                          }
                break ;  }
                }              
}

score2temp = score2;
score1temp = score1;
score1=0;
score2=0;
for(int i=0;i<8;i++){
	for(int j=0;j<8;j++){
		if( curr[i][j]==1)score1++;
		if( curr[i][j]==2)score2++;


	}
}
if (chance==1){
          if(score2temp==score2){
               score1=score1temp;
               curr[x][y]=0;
           printf("bro/gal 1 - be kind");
          }
}
else if (chance==2){
          if(score1temp==score1){
               score2=score2temp;
               curr[x][y]=0;
          printf("bro/gal 2 -be kind" );          
          }
}
printf("score1=%d\nscore2=%d\n ",score1,score2 );
for (int jk=0;jk<8;jk++){
  for (int kl=0;kl<8;kl++){
    printf("%d ",curr[jk][kl] );
  }
    printf("\n " );
}

}///while ends
////////////        end last
if(score2>score1) winner=2;
else if(score1>score2) winner=1;
else winner= 3;
return 0 ;


}

