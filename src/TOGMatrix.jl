module TOGMatrix

# using Adapt
using TOGColor: rgba2scalar

const MATRIX_CACHE = Dict{UInt,AbstractMatrix}()

struct ΦMatrix{M}
    matrix::M
    H::UInt32
    W::UInt32
end
function (f::ΦMatrix)(x)
    px = unsafe_trunc(UInt32, x[2] * (f.W - 1)) + 1
    py = unsafe_trunc(UInt32, (1 - x[3]) * (f.H - 1)) + 1
    f.matrix[py, px]
end
# function Adapt.adapt_structure(to, f::ΦMatrix)
#     ΦMatrix(Adapt.adapt(to, f.mat), f.H, f.W)
# end
function rgbamatrix(matrix)
    H, W = size(matrix)
    scalar = rgba2scalar.(matrix)
    ΦMatrix(scalar, UInt32(H), UInt32(W))
end

end
