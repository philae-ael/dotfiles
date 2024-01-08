call neomake#configure#automake("rwn")
call neomake#config#set('automake.cancelation_delay', [0.2, 0.5, 3000])


let g:neomake_python_enabled_markers =  ['pylama']
