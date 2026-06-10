# Composite before/after fireworks treatment mockup PNG
Add-Type -AssemblyName System.Drawing

$root = "C:\Users\Favor3d Pro\Desktop\Cursor\.cursor\Wedding Quote"
$fireworksPath = Join-Path $root "assets\photos\still-close.png"
$vowsPath = Join-Path $root "assets\photos\still-1.png"
$outWorkspace = Join-Path $root "mockup-fireworks-preview.png"
$outDesktop = "C:\Users\Favor3d Pro\Desktop\mockup-fireworks-preview.png"

# Brand palette
$ivory    = [System.Drawing.Color]::FromArgb(254, 252, 248)
$cream    = [System.Drawing.Color]::FromArgb(243, 235, 224)
$warmWhite= [System.Drawing.Color]::FromArgb(250, 246, 239)
$ink      = [System.Drawing.Color]::FromArgb(30, 22, 16)
$gold     = [System.Drawing.Color]::FromArgb(196, 146, 62)
$goldDk   = [System.Drawing.Color]::FromArgb(139, 100, 40)
$mid      = [System.Drawing.Color]::FromArgb(138, 112, 88)
$light    = [System.Drawing.Color]::FromArgb(184, 152, 120)
$borderLt = [System.Drawing.Color]::FromArgb(237, 229, 216)
$pageBg   = [System.Drawing.Color]::FromArgb(237, 234, 228)

function New-Font($family, $size, [System.Drawing.FontStyle]$style = [System.Drawing.FontStyle]::Regular) {
    try { return New-Object System.Drawing.Font($family, $size, $style) }
    catch { return New-Object System.Drawing.Font("Segoe UI", $size, $style) }
}

function Draw-TextCentered($g, $text, $font, $brush, $x, $y, $w) {
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Near
    $rect = New-Object System.Drawing.RectangleF($x, $y, $w, 200)
    $g.DrawString($text, $font, $brush, $rect, $sf)
}

function Draw-ContainImage($g, $img, $x, $y, $w, $h, $bgColor) {
    $brush = New-Object System.Drawing.SolidBrush($bgColor)
    $g.FillRectangle($brush, $x, $y, $w, $h)
    $brush.Dispose()
    $scale = [Math]::Min($w / $img.Width, $h / $img.Height)
    $dw = [int]($img.Width * $scale)
    $dh = [int]($img.Height * $scale)
    $dx = $x + [int](($w - $dw) / 2)
    $dy = $y + [int](($h - $dh) / 2)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.DrawImage($img, $dx, $dy, $dw, $dh)
}

function Draw-CoverImage($g, $img, $x, $y, $w, $h, $posX = 0.5, $posY = 0.5) {
    $scale = [Math]::Max($w / $img.Width, $h / $img.Height)
    $sw = $img.Width * $scale
    $sh = $img.Height * $scale
    $dx = $x + [int]($w * $posX - $sw * $posX)
    $dy = $y + [int]($h * $posY - $sh * $posY)
    $state = $g.Save()
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddRectangle([System.Drawing.Rectangle]::FromLTRB($x, $y, $x + $w, $y + $h))
    $g.SetClip($path)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($img, $dx, $dy, [int]$sw, [int]$sh)
    $g.Restore($state)
    $path.Dispose()
}

function Draw-SideFeather($g, $x, $y, $w, $h, $featherPct = 0.18) {
    $fw = [int]($w * $featherPct)
    $x1 = [int]$x
    $x2 = [int]($x + $fw)
    $x3 = [int]($x + $w - $fw)
    $x4 = [int]($x + $w)
    $y1 = [int]$y
    # Left gradient ivory -> transparent
    $lBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        ([System.Drawing.Point]::new($x1, $y1)),
        ([System.Drawing.Point]::new($x2, $y1)),
        $ivory,
        ([System.Drawing.Color]::FromArgb(0, 254, 252, 248))
    )
    $g.FillRectangle($lBrush, $x1, $y1, $fw, $h)
    $lBrush.Dispose()
    # Right gradient
    $rBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        ([System.Drawing.Point]::new($x3, $y1)),
        ([System.Drawing.Point]::new($x4, $y1)),
        ([System.Drawing.Color]::FromArgb(0, 254, 252, 248)),
        $ivory
    )
    $g.FillRectangle($rBrush, $x3, $y1, $fw, $h)
    $rBrush.Dispose()
}

# Canvas
$W = 1440
$H = 980
$bmp = New-Object System.Drawing.Bitmap($W, $H)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
$g.Clear($pageBg)

$fireworks = [System.Drawing.Image]::FromFile($fireworksPath)
$vows = [System.Drawing.Image]::FromFile($vowsPath)

# Fonts
$fontTitle   = New-Font "Georgia" 28 ([System.Drawing.FontStyle]::Italic)
$fontTag     = New-Font "Segoe UI" 11 ([System.Drawing.FontStyle]::Bold)
$fontHead    = New-Font "Georgia" 18 ([System.Drawing.FontStyle]::Italic)
$fontSub     = New-Font "Segoe UI" 10
$fontLabel   = New-Font "Segoe UI" 9
$fontCaption = New-Font "Segoe UI" 9 ([System.Drawing.FontStyle]::Italic)
$fontLetter  = New-Font "Georgia" 12 ([System.Drawing.FontStyle]::Italic)
$fontSmall   = New-Font "Segoe UI" 8 ([System.Drawing.FontStyle]::Bold)

$brushInk = New-Object System.Drawing.SolidBrush($ink)
$brushMid = New-Object System.Drawing.SolidBrush($mid)
$brushLight = New-Object System.Drawing.SolidBrush($light)
$brushGold = New-Object System.Drawing.SolidBrush($gold)
$brushGoldDk = New-Object System.Drawing.SolidBrush($goldDk)
$brushWhite = New-Object System.Drawing.SolidBrush($ivory)

# Top banner
$bannerBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle(0, 0, $W, 52)),
    $goldDk, $gold, 45
)
$g.FillRectangle($bannerBrush, 0, 0, $W, 52)
$bannerBrush.Dispose()
Draw-TextCentered $g "FIREWORKS TREATMENT - BEFORE / AFTER PREVIEW" (New-Font "Segoe UI" 9 ([System.Drawing.FontStyle]::Bold)) $brushWhite 0 18 $W

# Page title
Draw-TextCentered $g "Fireworks and Vows - Layout Preview" $fontTitle $brushInk 0 68 $W
Draw-TextCentered $g "Side-by-side mockup using your real portfolio photos" $fontSub $brushMid 0 108 $W

$panelW = 660
$panelH = 820
$gap = 36
$leftX = [int](($W - ($panelW * 2 + $gap)) / 2)
$rightX = $leftX + $panelW + $gap
$panelY = 148

function Draw-Panel($g, $x, $y, $w, $h, $tag, $tagColor, $title, $subtitle, $isProposed) {
    $shadow = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18, 40, 24, 8))
    $g.FillRectangle($shadow, $x + 6, $y + 8, $w, $h)
    $shadow.Dispose()

    $panelBrush = New-Object System.Drawing.SolidBrush($ivory)
    $g.FillRectangle($panelBrush, $x, $y, $w, $h)
    $panelBrush.Dispose()
    $pen = New-Object System.Drawing.Pen($borderLt)
    $g.DrawRectangle($pen, $x, $y, $w - 1, $h - 1)
    $pen.Dispose()

    $headBrush = New-Object System.Drawing.SolidBrush($warmWhite)
    $g.FillRectangle($headBrush, $x + 1, $y + 1, $w - 2, 88)
    $headBrush.Dispose()
    $headPen = New-Object System.Drawing.Pen($borderLt)
    $g.DrawLine($headPen, $x, $y + 89, $x + $w, $y + 89)
    $headPen.Dispose()

    $tagBrush = New-Object System.Drawing.SolidBrush($tagColor)
    $g.DrawString($tag, $fontTag, $tagBrush, ($x + 24), ($y + 18))
    $tagBrush.Dispose()
    $g.DrawString($title, $fontHead, $brushInk, ($x + 24), ($y + 38))
    $g.DrawString($subtitle, $fontSub, $brushLight, ($x + 24), ($y + 64))
}

# ── CURRENT panel ──
Draw-Panel $g $leftX $panelY $panelW $panelH "CURRENT" $gold "Mid slot, letterbox" "Fireworks above Film Experience" $false

$cx = $leftX + 32
$cy = $panelY + 108
$cw = $panelW - 64

# Context bar
$ctxBrush = New-Object System.Drawing.SolidBrush($warmWhite)
$g.FillRectangle($ctxBrush, $cx, $cy, $cw, 28)
$ctxBrush.Dispose()
Draw-TextCentered $g "After personal letter" $fontSmall $brushLight $cx ($cy + 8) $cw
$cy += 40

# Letter label
Draw-TextCentered $g "A Personal Note" $fontLabel $brushMid $cx $cy $cw
$cy += 26
$g.DrawString("...your wedding day deserves to be remembered exactly as it felt...", $fontLetter, $brushMid, ($cx + 12), $cy)
$cy += 52

# CURRENT mid slot — letterbox contain
$midW = [int]([Math]::Min($cw * 0.85, 580))
$midH = [int]([Math]::Min($midW * 586 / 628, 520))
$midX = $cx + [int](($cw - $midW) / 2)
Draw-ContainImage $g $fireworks $midX $cy $midW $midH $cream
$cy += $midH + 10
Draw-TextCentered $g "Mid slot - letterbox (contain + cream bars)" $fontCaption $brushLight $cx $cy $cw
$cy += 22
Draw-TextCentered $g "object-fit: contain, max-height: 520px" $fontCaption $brushLight $cx $cy $cw
$cy += 36

# Film placeholder
$filmBrush = New-Object System.Drawing.SolidBrush($warmWhite)
$g.FillRectangle($filmBrush, ($cx + 40), $cy, ($cw - 80), 44)
$filmBrush.Dispose()
$dashPen = New-Object System.Drawing.Pen($borderLt) ; $dashPen.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
$g.DrawRectangle($dashPen, ($cx + 40), $cy, ($cw - 80), 44)
$dashPen.Dispose()
Draw-TextCentered $g "Your Wedding Film Experience" $fontSmall $brushLight ($cx + 40) ($cy + 14) ($cw - 80)

# ── PROPOSED panel ──
Draw-Panel $g $rightX $panelY $panelW $panelH "PROPOSED" ([System.Drawing.Color]::FromArgb(122, 140, 112)) "Narrative reorder" "Vows after letter, fireworks before CTA" $true

$px = $rightX + 32
$py = $panelY + 108
$pw = $panelW - 64

$ctxBrush2 = New-Object System.Drawing.SolidBrush($warmWhite)
$g.FillRectangle($ctxBrush2, $px, $py, $pw, 28)
$ctxBrush2.Dispose()
Draw-TextCentered $g "After personal letter" $fontSmall $brushLight $px ($py + 8) $pw
$py += 40
Draw-TextCentered $g "A Personal Note" $fontLabel $brushMid $px $py $pw
$py += 26
$g.DrawString("...your wedding day deserves to be remembered exactly as it felt...", $fontLetter, $brushMid, ($px + 12), $py)
$py += 48

# PROPOSED mid — vows cover
$vowW = [int]($pw * 0.82)
$vowH = 240
$vowX = $px + [int](($pw - $vowW) / 2)
Draw-CoverImage $g $vows $vowX $py $vowW $vowH 0.5 0.5
$py += $vowH + 8
Draw-TextCentered $g "Mid slot - B and W vows (cover, 82% inset)" $fontCaption $brushLight $px $py $pw
$py += 28

# Film section placeholder (compressed)
$filmBrush2 = New-Object System.Drawing.SolidBrush($warmWhite)
$g.FillRectangle($filmBrush2, ($px + 30), $py, ($pw - 60), 36)
$filmBrush2.Dispose()
$dashPen2 = New-Object System.Drawing.Pen($borderLt) ; $dashPen2.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
$g.DrawRectangle($dashPen2, ($px + 30), $py, ($pw - 60), 36)
$dashPen2.Dispose()
Draw-TextCentered $g "Film Experience ... package ... testimonial ..." $fontSmall $brushLight ($px + 30) ($py + 11) ($pw - 60)
$py += 52

$ctxBrush3 = New-Object System.Drawing.SolidBrush($warmWhite)
$g.FillRectangle($ctxBrush3, $px, $py, $pw, 28)
$ctxBrush3.Dispose()
Draw-TextCentered $g "Before Reserve Your Date" $fontSmall $brushLight $px ($py + 8) $pw
$py += 38

# PROPOSED pre-CTA fireworks — cover center 90% + side feather
$fwW = [int]($pw * 0.90)
$fwH = 280
$fwX = $px + [int](($pw - $fwW) / 2)
Draw-CoverImage $g $fireworks $fwX $py $fwW $fwH 0.5 0.9
Draw-SideFeather $g $fwX $py $fwW $fwH 0.18
$py += $fwH + 10
Draw-TextCentered $g "Pre-CTA - fireworks finale (cover, center 90%)" $fontCaption $brushLight $px $py $pw
$py += 20
Draw-TextCentered $g "Ivory side feather, no cream letterbox bars" $fontCaption $brushLight $px $py $pw
$py += 28

# CTA placeholder
$ctaBrush = New-Object System.Drawing.SolidBrush($warmWhite)
$g.FillRectangle($ctaBrush, ($px + 80), $py, ($pw - 160), 40)
$ctaBrush.Dispose()
$ctaPen = New-Object System.Drawing.Pen($borderLt)
$g.DrawRectangle($ctaPen, ($px + 80), $py, ($pw - 160), 40)
$ctaPen.Dispose()
Draw-TextCentered $g "Reserve Your Date" $fontSmall $brushGoldDk ($px + 80) ($py + 12) ($pw - 160)

# Footer
Draw-TextCentered $g "Preview only - favor3dpro-quote.html unchanged" $fontCaption $brushLight 0 ($H - 36) $W

# Save
$bmp.Save($outWorkspace, [System.Drawing.Imaging.ImageFormat]::Png)
Copy-Item -Path $outWorkspace -Destination $outDesktop -Force

Write-Output "Saved: $outWorkspace"
Write-Output "Saved: $outDesktop"
Write-Output "Dimensions: ${W}x${H}"

# Cleanup
$g.Dispose(); $bmp.Dispose(); $fireworks.Dispose(); $vows.Dispose()
foreach ($b in @($brushInk,$brushMid,$brushLight,$brushGold,$brushGoldDk,$brushWhite)) { $b.Dispose() }
foreach ($f in @($fontTitle,$fontTag,$fontHead,$fontSub,$fontLabel,$fontCaption,$fontLetter,$fontSmall)) { $f.Dispose() }
