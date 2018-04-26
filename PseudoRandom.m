% unfinished


function stimulusList=PseudoRandom(stimList,groupList)
%     Blocks      = 4;
%     
%     numOfstim1 = 16;
%     numOfstim2 = 256;
%     numOfstim3 = 16;
%     % line 1:
%     [groupList,stimList]  = RandomGroup(numOfstim1,numOfstim2/Blocks,numOfstim3/Blocks);




    % line 2:
    stimList2(groupList==1)=stimList(groupList==1);
    stimList2(groupList==2)=stimList(groupList==2)+256/4;
    stimList2(groupList==3)=stimList(groupList==3)+16/4;
    % line 3:
    stimList3(groupList==1)=stimList2(groupList==1);
    stimList3(groupList==2)=stimList2(groupList==2)+256/4;
    stimList3(groupList==3)=stimList2(groupList==3)+16/4;
    % line 4:
    stimList4(groupList==1)=stimList3(groupList==1);
    stimList4(groupList==2)=stimList3(groupList==2)+256/4;
    stimList4(groupList==3)=stimList3(groupList==3)+16/4;
    
    stimulusList = [stimList;stimList2;stimList3;stimList4];    
end

    % line 1:
    [groupList, stimList]  = RandomGroup(numOfstim1,numOfstim2/Blocks,numOfstim3/Blocks);
    % line 2:
    stimList2(groupList==1)=stimList(groupList==1);
    stimList2(groupList==2)=stimList(groupList==2)+numOfstim2/Blocks;
    stimList2(groupList==3)=stimList(groupList==3)+numOfstim3/Blocks;
    % line 3:
    stimList3(groupList==1)=stimList2(groupList==1);
    stimList3(groupList==2)=stimList2(groupList==2)+numOfstim2/Blocks;
    stimList3(groupList==3)=stimList2(groupList==3)+numOfstim3/Blocks;
    % line 4:
    stimList4(groupList==1)=stimList3(groupList==1);
    stimList4(groupList==2)=stimList3(groupList==2)+numOfstim2/Blocks;
    stimList4(groupList==3)=stimList3(groupList==3)+numOfstim3/Blocks;
    % line 5:
    stimList5(groupList==1)=stimList4(groupList==1);
    stimList5(groupList==2)=stimList4(groupList==2)+numOfstim2/Blocks;
    stimList5(groupList==3)=stimList4(groupList==3)+numOfstim3/Blocks;
    
    stimulusList = [stimList;stimList2;stimList3;stimList4;stimList5]; 