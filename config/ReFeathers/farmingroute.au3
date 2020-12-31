#include <Array.au3>

Func CreateFarmingRoute()
	local $temproute1[1], $temproute2[1]
	_ArrayAdd($temproute1,12020)
    _ArrayAdd($temproute2,-6218)
	_ArrayAdd($temproute1,12021)
    _ArrayAdd($temproute2,-5815)
	if Random()>0.5 Then
		_ArrayAdd($temproute1,11012)
        _ArrayAdd($temproute2,-8538)
		_ArrayAdd($temproute1,7035)
        _ArrayAdd($temproute2,-8809)
		_ArrayAdd($temproute1,7190)
        _ArrayAdd($temproute2,-6910)
		_ArrayAdd($temproute1,6617)
        _ArrayAdd($temproute2,-5746)
		_ArrayAdd($temproute1,4404)
        _ArrayAdd($temproute2,-4583)
	Else
		_ArrayAdd($temproute1,10069)
        _ArrayAdd($temproute2,-6791)
		_ArrayAdd($temproute1,8678)
        _ArrayAdd($temproute2,-6602)
		_ArrayAdd($temproute1,7020)
        _ArrayAdd($temproute2,-5578)
		_ArrayAdd($temproute1,5033)
        _ArrayAdd($temproute2,-4532)
	EndIf
	_ArrayAdd($temproute1,4202)
    _ArrayAdd($temproute2,-1804)
	_ArrayAdd($temproute1,1519)
    _ArrayAdd($temproute2,-763)
	_ArrayAdd($temproute1,381)
    _ArrayAdd($temproute2,657)
	_ArrayAdd($temproute1,-499)
    _ArrayAdd($temproute2,1758)
	if Random()>0.5 Then
		_ArrayAdd($temproute1,-1697)
        _ArrayAdd($temproute2,2359)
		_ArrayAdd($temproute1,-1041)
        _ArrayAdd($temproute2,1597)
		_ArrayAdd($temproute1,-1589)
        _ArrayAdd($temproute2,709)
	Else
		_ArrayAdd($temproute1,-492)
        _ArrayAdd($temproute2,2537)
		_ArrayAdd($temproute1,-2256)
        _ArrayAdd($temproute2,-8809)
		_ArrayAdd($temproute1,-3205)
        _ArrayAdd($temproute2,2418)
		_ArrayAdd($temproute1,-3691)
        _ArrayAdd($temproute2,888)
		_ArrayAdd($temproute1,-2551)
        _ArrayAdd($temproute2,-521)
	EndIf
	_ArrayAdd($temproute1,-2458)
    _ArrayAdd($temproute2,-1202)
	if Random(1,9)>3 Then
		_ArrayAdd($temproute1,-3988)
        _ArrayAdd($temproute2,-2440)
		_ArrayAdd($temproute1,-5791)
        _ArrayAdd($temproute2,-3179)
		_ArrayAdd($temproute1,-6375)
        _ArrayAdd($temproute2,-3320)
		_ArrayAdd($temproute1,-6915)
        _ArrayAdd($temproute2,-2723)
		_ArrayAdd($temproute1,-6475)
        _ArrayAdd($temproute2,-3140)
		_ArrayAdd($temproute1,-5503)
        _ArrayAdd($temproute2,-3532)
		_ArrayAdd($temproute1,-2205)
        _ArrayAdd($temproute2,-3590)
	Else
		_ArrayAdd($temproute1,-3640)
        _ArrayAdd($temproute2,-1384)
		_ArrayAdd($temproute1,-5848)
        _ArrayAdd($temproute2,-1337)
		_ArrayAdd($temproute1,-5408)
        _ArrayAdd($temproute2,-2561)
		_ArrayAdd($temproute1,-1834)
        _ArrayAdd($temproute2,-3063)
	EndIf
	_ArrayAdd($temproute1,-732)
    _ArrayAdd($temproute2,-4359)
	_ArrayAdd($temproute1,-353)
    _ArrayAdd($temproute2,-6682)
	_ArrayAdd($temproute1,-2056)
    _ArrayAdd($temproute2,-8224)
	_ArrayAdd($temproute1,-4218)
    _ArrayAdd($temproute2,-7767)
	_ArrayAdd($temproute1,-6150)
    _ArrayAdd($temproute2,-7394)
	_ArrayAdd($temproute1,-7660)
    _ArrayAdd($temproute2,-9095)
	if Random()>(0.5) Then
		_ArrayAdd($temproute1,-8455)
        _ArrayAdd($temproute2,-7300)
		_ArrayAdd($temproute1,-8778)
        _ArrayAdd($temproute2,-8544)
		_ArrayAdd($temproute1,-10431)
        _ArrayAdd($temproute2,-8705)
		_ArrayAdd($temproute1,-13613)
        _ArrayAdd($temproute2,-4731)
		_ArrayAdd($temproute1,-14189)
        _ArrayAdd($temproute2,-2634)
		_ArrayAdd($temproute1,-13513)
        _ArrayAdd($temproute2,-1885)
		_ArrayAdd($temproute1,-10872)
        _ArrayAdd($temproute2,-3658)
	Else
		_ArrayAdd($temproute1,-10431)
        _ArrayAdd($temproute2,-8705)
		_ArrayAdd($temproute1,-8778)
        _ArrayAdd($temproute2,-8544)
		_ArrayAdd($temproute1,-8455)
        _ArrayAdd($temproute2,-7300)
		_ArrayAdd($temproute1,-11805)
        _ArrayAdd($temproute2,-2157)
		_ArrayAdd($temproute1,-13513)
        _ArrayAdd($temproute2,-1885)
		_ArrayAdd($temproute1,-14431)
        _ArrayAdd($temproute2,-2471)
	EndIf
	_ArrayAdd($temproute1,-12139)
    _ArrayAdd($temproute2,-1372)
	_ArrayAdd($temproute1,-12015)
    _ArrayAdd($temproute2,816)
	if Random(1,9)>3 Then
		_ArrayAdd($temproute1,-10676)
        _ArrayAdd($temproute2,3225)
		_ArrayAdd($temproute1,-10009)
        _ArrayAdd($temproute2,3637)
		_ArrayAdd($temproute1,-10465)
        _ArrayAdd($temproute2,5466)
	Else
		_ArrayAdd($temproute1,-12820)
        _ArrayAdd($temproute2,1431)
		_ArrayAdd($temproute1,-12757)
        _ArrayAdd($temproute2,3277)
	EndIf
	Local $route[UBound($temproute1)-1][2]
	For $i = 1 To UBound($temproute1) - 1
		$route[$i-1][0] = $temproute1[$i]
		$route[$i-1][1] = $temproute2[$i]
	Next
	Sleep(Random(1000,2000))
	Return $route
EndFunc   ;==>Farm