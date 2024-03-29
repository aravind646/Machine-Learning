## Copyright (C) 2013 Carnë Draug <carandraug@octave.org>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn  {Function File} {} bwperim (@var{bw})
## @deftypefnx {Function File} {} bwperim (@var{bw}, @var{conn})
## Find perimeter of objects in binary images.
##
## Values from the matrix @var{bw} are considered part of an object perimeter
## if their value is non-zero and is connected to at least one zero-valued
## element.
##
## Element connectivity @var{conn}, to define the size of objects, can be
## specified with a numeric scalar (number of elements in the neighborhood):
##
## @table @samp
## @item 4 or 8
## for 2 dimensional matrices;
## @item 6, 18 or 26
## for 3 dimensional matrices;
## @end table
##
## or with a binary matrix representing a connectivity array.  Defaults to
## @code{conndef (ndims (@var{bw}), "minimal")} which is equivalent to
## @var{conn} of 4 and 6 for 2 and 3 dimensional matrices respectively.
##
## @seealso{bwarea, bwboundaries, imerode, mmgrad}
## @end deftypefn

function varargout = bwperim (bw, conn)

  if (nargin < 1 || nargin > 2)
    print_usage ();
  elseif (! ismatrix (bw) || ! (isnumeric (bw) || islogical (bw)))
    error("bwperim: BW must be a numeric matrix");
  endif

  nDims = ndims (bw);
  if (nargin < 2)
    ## Defining default connectivity here because it's dependent
    ## on the first argument
    conn = conndef (nDims, "minimal");
  else
    conn = make_conn ("bwperim", 2, nDims, conn);
  endif

  ## Make sure bw is logical;
  bw = logical (bw);

  ## Recover the elements that would get removed by erosion
  perim = (! imerode (bw, conn)) & bw;

  ## Get the borders back (they are removed during erosion
  tmp_idx = repmat ({":"}, [1 nDims]);
  p_size  = size (perim);
  for dim = 1:nDims
    idx       = tmp_idx;
    idx{dim}  = [1 p_size(dim)];
    perim(idx{:}) = bw(idx{:});
  endfor

  if (nargout > 0)
    varargout{1} = perim;
  else
    imshow (perim);
  endif
endfunction

%!shared in, out
%! in = [ 1   1   1   1   0   1   1   0   1   1
%!        1   1   0   1   1   1   1   1   1   0
%!        1   1   1   0   1   1   1   1   1   1
%!        1   1   1   1   0   1   1   1   0   1
%!        1   1   1   0   1   1   1   1   1   0
%!        1   1   1   1   1   1   0   1   0   1
%!        1   1   1   1   1   1   1   1   1   0
%!        1   1   1   1   1   1   1   1   1   1
%!        1   1   1   1   1   1   0   0   1   1
%!        1   1   1   1   0   1   0   1   1   0];
%!
%! out = [1   1   1   1   0   1   1   0   1   1
%!        1   1   0   1   1   0   0   1   1   0
%!        1   0   1   0   1   0   0   0   1   1
%!        1   0   0   1   0   1   0   1   0   1
%!        1   0   1   0   1   0   1   0   1   0
%!        1   0   0   1   0   1   0   1   0   1
%!        1   0   0   0   0   0   1   0   1   0
%!        1   0   0   0   0   0   1   1   0   1
%!        1   0   0   0   1   1   0   0   1   1
%!        1   1   1   1   0   1   0   1   1   0];
%!assert (bwperim (in), logical (out));
%!assert (bwperim (in, 4), logical (out));
%!
%! out = [1   1   1   1   0   1   1   0   1   1
%!        1   1   0   1   1   1   1   1   1   0
%!        1   1   1   0   1   1   0   1   1   1
%!        1   0   1   1   0   1   0   1   0   1
%!        1   0   1   0   1   1   1   1   1   0
%!        1   0   1   1   1   1   0   1   0   1
%!        1   0   0   0   0   1   1   1   1   0
%!        1   0   0   0   0   1   1   1   1   1
%!        1   0   0   1   1   1   0   0   1   1
%!        1   1   1   1   0   1   0   1   1   0];
%!assert (bwperim (in, 8), logical (out));
%!
%! out = [1   1   1   1   0   1   1   0   1   1
%!        1   0   0   0   0   1   0   0   1   0
%!        1   0   0   0   0   0   0   1   0   1
%!        1   0   1   0   0   0   0   0   0   1
%!        1   0   0   0   0   1   0   1   0   0
%!        1   0   0   0   1   0   0   0   0   1
%!        1   0   0   0   0   0   0   1   0   0
%!        1   0   0   0   0   1   1   0   0   1
%!        1   0   0   1   0   1   0   0   1   1
%!        1   1   1   1   0   1   0   1   1   0];
%!assert (bwperim (in, [1 0 0; 0 1 0; 0 0 1]), logical (out));

## test that any non-zero value is valid (even i and Inf)
%!shared in, out
%! in = [ 0   0   0   0   0   0   0
%!        0   0   5   0   0   1   9
%!        0 Inf   9   7   0   0   0
%!        0 1.5   5   7   1   0   0
%!        0 0.5  -1  89   i   0   0
%!        0   4  10  15   1   0   0
%!        0   0   0   0   0   0   0];
%! out = [0   0   0   0   0   0   0
%!        0   0   1   0   0   1   1
%!        0   1   0   1   0   0   0
%!        0   1   0   0   1   0   0
%!        0   1   0   0   1   0   0
%!        0   1   1   1   1   0   0
%!        0   0   0   0   0   0   0];
%!assert (bwperim (in), logical (out));

## test for 3D
%!shared in, out
%! in = reshape (magic(16), [8 8 4]) > 50;
%! out(:,:,1) = [
%!    1   1   0   1   0   1   1   1
%!    0   1   1   1   1   1   0   1
%!    0   1   1   1   1   1   0   1
%!    1   1   0   1   1   1   1   1
%!    1   1   1   1   1   1   1   1
%!    1   1   1   0   1   0   1   1
%!    1   1   1   0   1   0   1   1
%!    1   0   1   1   1   1   1   0];
%! out(:,:,2) = [
%!    1   1   0   1   0   1   1   1
%!    0   1   1   0   1   1   0   1
%!    0   1   0   0   0   1   0   1
%!    1   0   1   0   0   0   1   1
%!    1   0   0   1   0   1   0   1
%!    1   0   1   0   1   0   1   1
%!    1   1   1   0   1   0   1   1
%!    1   0   1   1   1   1   1   0];
%! out(:,:,3) = [
%!    1   1   0   1   0   1   1   1
%!    0   1   1   0   1   1   0   1
%!    0   1   0   0   0   1   0   1
%!    1   0   0   0   0   0   1   1
%!    1   0   0   1   0   1   0   1
%!    1   0   1   0   1   0   1   1
%!    1   1   1   0   1   0   1   1
%!    1   0   1   1   1   1   1   0];
%! out(:,:,4) = [
%!    1   1   0   1   0   1   1   1
%!    0   1   1   1   1   1   0   1
%!    0   1   1   1   1   1   0   1
%!    1   1   1   1   1   1   1   1
%!    1   1   1   1   1   1   1   0
%!    1   1   1   0   1   0   1   1
%!    1   1   1   0   1   0   1   1
%!    1   0   1   1   1   1   1   0];
%!assert (bwperim (in), logical (out));
%!
%! out(:,:,1) = [
%!    1   1   0   1   0   1   1   1
%!    0   1   1   1   1   1   0   1
%!    0   1   1   1   1   1   0   1
%!    1   1   0   1   1   1   1   1
%!    1   1   1   1   1   1   1   1
%!    1   1   1   0   1   0   1   1
%!    1   1   1   0   1   0   1   1
%!    1   0   1   1   1   1   1   0];
%! out(:,:,2) = [
%!    1   1   0   1   0   1   1   1
%!    0   1   1   1   1   1   0   1
%!    0   1   1   0   0   1   0   1
%!    1   1   1   1   0   1   1   1
%!    1   0   1   1   1   1   1   1
%!    1   0   1   0   1   0   1   1
%!    1   1   1   0   1   0   1   1
%!    1   0   1   1   1   1   1   0];
%! out(:,:,3) = [
%!    1   1   0   1   0   1   1   1
%!    0   1   1   1   1   1   0   1
%!    0   1   0   0   0   1   0   1
%!    1   1   0   0   0   1   1   1
%!    1   0   1   1   1   1   1   1
%!    1   0   1   0   1   0   1   1
%!    1   1   1   0   1   0   1   1
%!    1   0   1   1   1   1   1   0];
%! out(:,:,4) = [
%!    1   1   0   1   0   1   1   1
%!    0   1   1   1   1   1   0   1
%!    0   1   1   1   1   1   0   1
%!    1   1   1   1   1   1   1   1
%!    1   1   1   1   1   1   1   0
%!    1   1   1   0   1   0   1   1
%!    1   1   1   0   1   0   1   1
%!    1   0   1   1   1   1   1   0];
%!assert (bwperim (in, 18), logical (out));

%!error bwperim ("text")
%!error bwperim (rand (10), 5)
%!error bwperim (rand (10), "text")
