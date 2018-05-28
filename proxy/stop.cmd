set Arr[0]=apple
set Arr[1]=banana
set Arr[2]=cherry
set Arr[3]=donut

set "x=0"

:SymLoop
if defined Arr[%x%] (
    call echo %%Arr[%x%]%%
    set /a "x+=1"
    GOTO :SymLoop
)
